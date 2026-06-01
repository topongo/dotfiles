-- Sink volume toggle mute
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true, repeating = true })
-- Source volume toggle mute
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true, repeating = true })

-- Volume raise with custom value
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume 5 --max-volume 150"), { locked = true, repeating = true })
-- Volume lower with custom value
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -5 --max-volume 150"), { locked = true, repeating = true })

-- Volume raise with max value
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise --max-volume 120"), { locked = true, repeating = true })
-- # Volume lower with max value
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower --max-volume 120"), { locked = true, repeating = true })

-- Sink volume raise with custom value optionally with --device
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +10 --device alsa_output.pci-0000_11_00.4.analog-stereo.monitor"), { locked = true, repeating = true })
-- # Sink volume lower with custom value optionally with --device
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -10 --device alsa_output.pci-0000_11_00.4.analog-stereo.monitor"), { locked = true, repeating = true })

-- Capslock (If you don't want to use the backend)
-- bindsym --release Caps_Lock exec swayosd-client --caps-lock
-- Capslock but specific LED name (/sys/class/leds/)
-- bindsym --release Caps_Lock exec swayosd-client --caps-lock-led input19::capslock

-- Brightness raise
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
-- Brightness lower
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true, repeating = true })

-- Brightness raise with custom value('+' sign needed)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness +10"), { locked = true, repeating = true })
-- Brightness lower with custom value('-' sign needed)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -10"), { locked = true, repeating = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playing-rs op toggle && swayosd-client --custom-message \"Play/Pause\" --custom-icon media-playback-start"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playing-rs op next && swayosd-client --custom-message \"Next\" --custom-icon media-skip-forward"), { locked = true, repeating = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playing-rs op previous && swayosd-client --custom-message \"Previous\" --custom-icon media-skip-backward"), { locked = true, repeating = true })
