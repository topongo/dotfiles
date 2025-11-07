mp.add_hook("on_load", 100, function()
  -- replace uri mpv://yt//www.youtube.com/watch... with https://www.youtube.com/watch...
  local uri = string.gsub(mp.get_property("path"), "^mpv://yt//", "https://")
  if uri ~= mp.get_property("path") then
    mp.commandv("loadfile", uri, "replace")
  end
end)
