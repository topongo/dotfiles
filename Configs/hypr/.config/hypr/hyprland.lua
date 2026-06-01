-- ############### SETUP ###############
-- #####################################

require("private")

local f = io.popen("/bin/hostname")
local hostname
if f == nil then
  hostname = ""
else
  hostname = f:read("*a") or ""
  hostname = string.gsub(hostname, "\n$", "")
  f:close()
end

-- In-config variables
TERMINAL = "kitty"
FILE_MANAGER = TERMINAL .. " -e joshuto"
MENU = "hyprlauncher"
MAINMOD = "SUPER"

-- ############### ENVIRONMENT ###############
-- ###########################################

hl.env("HOSTNAME", hostname)

if hostname == "topongoPC" then
  hl.env("LIBVA_DRIVER_NAME", "nvidia")
  hl.env("GBM_BACKEND", "nvidia-drm")
  hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
  hl.env("NVD_BACKEND", "direct")
  hl.env("ELECTRON_OZONE_PLATFORM", "auto")
  hl.env("GDK_SCALE", "2")

elseif hostname == "PathFinder" then

end


-- ############### MONITORS ###############
-- ########################################

if hostname == "topongoPC" then
  hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 2 })
  hl.monitor({ output = "DP-1", mode = "preferred", position = "auto", scale = 2 })
elseif hostname == "PathFinder" then
  hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
end

-- Cursor settings
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- XDG settings
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Tell toolkits to use wayland backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- Other Application Environment Settings
hl.env("EWW_CONF", "~/.config/eww")
hl.env("TERMINAL", TERMINAL)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- ############### AUTOSTART ###############
-- #########################################

hl.on("hyprland.start", function ()
  hl.exec_cmd("hyprlock --grace 0 || hyprctl dispatch 'hl.exit()'")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")

  hl.exec_cmd("eww open mainbar")
  hl.exec_cmd("[[ -d /tmp/topongo ]] || mkdir /tmp/topongo")
  hl.exec_cmd("(while ! killall -0 eww; do sleep 1; done; sleep 5; vesktop --start-minimized)")
  hl.exec_cmd("localsend --hidden")
  hl.exec_cmd("~/.config/hypr/scripts/floating_bitwarden.sh")
  hl.exec_cmd("swayosd-server")
end)

-- ############### CONFIGURATION ###############
-- #############################################

hl.config({
general = {
    gaps_in = 3,
    gaps_out = 5,
    col = {
      active_border = "rgba(33ccffee)",
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },
  cursor = {
    no_hardware_cursors = true,
  },
  xwayland = {
    force_zero_scaling = true,
  },
  decoration = {
    rounding = 5,
    shadow = {
      enabled = true,
      render_power = 3,
      range = 4,
      color = "rgba(1a1a1aee)",
    },
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },
  animations = {
    enabled = true,
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    allow_small_split = true,
    new_status = "master",
  },
  misc = {
    force_default_wallpaper = 1,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    enable_anr_dialog = false,
  },

  input = {
    kb_layout = "us",
    -- kb_variant = "",
    -- kb_model = "",
    kb_options = "grp:alt_shift_toggle, compose:ralt",
    -- kb_rules = "",
    follow_mouse = 1,
    sensitivity = 0.5,
    accel_profile = "flat",
    numlock_by_default = true,

    touchpad = {
      disable_while_typing = false,
      natural_scroll = true,
    },
  },
})

-- Animations
hl.curve("bounce", { type = "bezier", points = {{0.05, 0.9}, {0.1, 1.05 }}})
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "bounce" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "bounce" })


-- ############### BINDS ###############
-- #####################################

local function mainmod(oth)
  return MAINMOD .. " + " .. oth
end

-- Windows + Layouts
hl.bind(mainmod("SHIFT + Q"), hl.dsp.window.close())
hl.bind(mainmod("SHIFT + F"), hl.dsp.window.fullscreen())
hl.bind(mainmod("SHIFT + Space"), hl.dsp.window.float())
hl.bind(mainmod("Space"), hl.dsp.window.pin())
hl.bind(mainmod("P"), hl.dsp.window.pseudo())
hl.bind(mainmod("E"), hl.dsp.layout("togglesplit"), { repeating = true })
-- hl.bind(mainmod("W"), hl.dsp.layout("togglegroup"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy"))
hl.bind(mainmod("Print"), hl.dsp.exec_cmd("slurp | grim -g - /tmp/slurp.png; feh /tmp/slurp.png"))

-- Bind applications runners
for _, app in pairs({
  { "T", TERMINAL },
  { "F", "firefox" },
  { "C", FILE_MANAGER },
  { "D", MENU },
  { "J", "joplin-desktop" },
  { "S", "kitty -e spotatui" },
  { "SHIFT + S", "spotify" },
  { "SHIFT + E", "eww reload || eww open mainbar" },
}) do
  hl.bind(mainmod(app[1]), hl.dsp.exec_cmd(app[2]), app[3])
end

-- Move focus
for _, d in pairs({"up", "down", "left", "right"}) do
  hl.bind(mainmod(d), hl.dsp.focus({ direction = d }))
end

-- Switch workspace
for i = 1, 10 do
  hl.bind(mainmod(tostring(i % 10)), hl.dsp.focus({ workspace = tostring(i) }))
  hl.bind(mainmod("SHIFT + " .. tostring(i % 10)), hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mainmod("TAB"), hl.dsp.focus({ workspace = "previous"}))

-- Scroll through workspaces
hl.bind(mainmod("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainmod("mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

-- Move/Resize windows
hl.bind(mainmod("mouse:272"), hl.dsp.window.drag(), { follow_mouse = true })
hl.bind(mainmod("mouse:273"), hl.dsp.window.resize(), { follow_mouse = true })

-- Touchpad Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "pinchin", action = "float"})

-- Laptop Lid Switch
if hostname == "PathFinder" then
  hl.bind("switch:on:Lid Switch", function()
    -- using dpms directly on dispatch can cause problems,
    -- see https://wiki.hypr.land/Configuring/Basics/Dispatchers/#cursor
    hl.timer(function()
      hl.dispatch(hl.dsp.dpms({ action = "off" }))
    end, { timeout = 500, type = "oneshot" })
    hl.dispatch(hl.dsp.exec_cmd("~/bin/suspend-inhibited"))
    hl.dispatch(hl.dsp.exec_cmd("hyprlock"))
  end)

  hl.bind("switch:off:Lid Switch", function()
    hl.timer(function()
      hl.dispatch(hl.dsp.dpms({ action = "on"}))
    end, { timeout = 500, type = "oneshot" })
  end)
end

-- Swayosd binds
require("swayosd")

-- ############### WINDOW RULES ###############
-- ############################################

hl.window_rule({
  name = "suppress-maximize",
  match = { class = ".*" },
  suppress_event = "maximize",
})
hl.window_rule({
  name = "floating-screenshot",
  match = { class = "feh", title = "ScreenshotFloat" },
  float = true,
})
hl.window_rule({
  name = "red-highlight-xwayland",
  match = { xwayland = true },
  border_color = "rgb(ff0000)",
})
hl.window_rule({
  name = "float-calculator",
  match = { class = "org.gnome.Calculator" },
  float = true,
})
