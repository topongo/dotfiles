function toggle_blackout()
  local channel = os.getenv("MPV_NTFY_CHANNEL")
  if not channel then
    channel = os.getenv("NTFY_MPV_CHANNEL")
  end

  if not channel then
    mp.osd_message("Cannot send to ntfy: channel unset")
    return
  end
  local endpoint = "https://ntfy.sh/" .. channel
  local path = mp.get_property("path")
  -- local path = "patthone"

  -- if path contains "youtube.com" and doens't contain a time argument
  if path:find("youtube.com") ~= nil and not (path:find("t=") ~= nil) then
    path = path .. "&t=" .. math.floor(mp.get_property("time-pos"))
  end

  mp.osd_message("Sending path (" .. path .. ") to ntfy channel: " .. endpoint)

  mp.command(
    "run curl" ..
    " https://ntfy.sh/" .. channel ..
    " -d 'Currently playing: " .. path .. "'" ..
    " -H 'actions: http, Open video, " .. path .. ", clear=true'"
  )
end

-- toggle_blackout()

mp.add_key_binding("B", "blackout", toggle_blackout)

