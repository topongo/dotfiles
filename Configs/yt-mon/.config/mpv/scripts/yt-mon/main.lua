local mp = require('mp')
local utils = require('mp.utils')
local interval = 5
local endpoint = "http://127.0.0.1:6123"
local usage_prev = nil
local cwd = mp.get_script_directory()
local files = {
  ping = {
    out = cwd .. "/.tmp/ping.out",
    err = cwd .. "/.tmp/ping.err",
  },
  atom = {
    out = cwd .. "/.tmp/atom.out",
    err = cwd .. "/.tmp/atom.err",
  },
}
local base_script = ([[
  url="%s"
  out="%s"
  err="%s"
  dout="$(dirname "$out")"
  derr="$(dirname "$err")"
  [ -f "$out" ] && rm "$out"
  [ -f "$err" ] && rm "$err"
  mkdir -p "$dout" "$derr"
  curl --no-progress-meter "$url" >"$out" 2>"$err"
]])
local scripts = {
  atom = base_script:format(
    endpoint .. "/atom/" .. interval,
    files.atom.out,
    files.atom.err
  ),
  ping = base_script:format(
    endpoint .. "/ping",
    files.ping.out,
    files.ping.err
  ),
}

local function message_and_exit(mess)
  print(mess)
  mp.osd_message("yt-mon: " .. mess)
  mp.add_timeout(4, function() mp.command("quit-watch-later") end)
end

local function parse_files(json, error)
  local f, e, c = io.open(json, "r")
  local iserr = false
  local raw = nil
  if f == nil then
    iserr = true
  else
    raw = f:read("*all")
    if raw == "" then
      iserr = true
    end
  end

  if iserr then
    local fe, ee, ce = io.open(error, "r")
    if fe == nil then
      return nil, ("could not open out file (%s) nor err file (%s)"):format(e, ee)
    else
      return nil, fe:read("*all")
    end
  else
    local data, _ = utils.parse_json(raw)
    if data == nil then
      return nil, "json error, raw: " .. raw
    else
      return data, nil
    end
  end
end

local function send_atom()
  local pause = mp.get_property("pause")
  local video_track, _ = mp.get_property("current-tracks/video")
  if pause == "no" and video_track ~= nil then
    -- send atom
    os.execute(("sh -c '%s'"):format(scripts.atom))
    -- local f, error, code = io.open(files.atom.out, "r")
    -- if code == 2 or f == nil then
    --   fail("cannot send atom to monitor server")
    --   return
    -- end
    local data, err = parse_files(files.atom.out, files.atom.err)
    if data == nil then
      message_and_exit(err)
      return
    else
      if data.ok then
        print(("yt-mon: usage %0.1f%%"):format(data.usage * 100))
        if usage_prev == nil or math.abs(data.usage - usage_prev) > .1 then
          if usage_prev == nil then
            usage_prev = 0
          end
          mp.osd_message(("yt-mon: usage %0.1f%%"):format(data.usage * 100))
          usage_prev = data.usage
        end
      else
        message_and_exit(data.reason)
        return
      end
    end
  end
end

mp.add_hook("on_load", 90, function()
  -- is it a yt video?
  if not mp.get_property("path"):find("^https://www.youtube.com") then
    print("not a youtube video")
    return
  end

  -- check for server
  os.execute(("sh -c '%s'"):format(scripts.ping))

  local data, err = parse_files(files.ping.out, files.ping.err)
  if data == nil then
    message_and_exit(err)
    return
  elseif data.usage > 1 then
    message_and_exit(("usage exceeded (%0.1f%%)"):format(data.usage * 100))
  else
    mp.add_periodic_timer(interval, send_atom)
  end
end)

