local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function scheme_for_appearance(appearance)
  -- Macchiato, Frappe, Latte, Mocha
  if appearance:find("Dark") then
    return "Catppuccin Frappe"
  else
    return "Catppuccin Latte"
  end
end

local function set_keys()
  local act = wezterm.action
  keys = {
    {
      key = "n",
      mods = "SHIFT|CTRL",
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = '1', mods = 'CMD', action = act.SendString "\x13\x31"
    },
    {
      key = '2', mods = 'CMD', action = act.SendString "\x13\x32"
    },
    {
      key = '3', mods = 'CMD', action = act.SendString "\x13\x33"
    },
    {
      key = '4', mods = 'CMD', action = act.SendString "\x13\x34"
    },
    {
      key = '5', mods = 'CMD', action = act.SendString "\x13\x35"
    },
    {
      key = '6', mods = 'CMD', action = act.SendString "\x13\x36"
    },
    {
      key = '7', mods = 'CMD', action = act.SendString "\x13\x37"
    },
    {
      key = '8', mods = 'CMD', action = act.SendString "\x13\x38"
    },
  }
  return keys
end

config.font = wezterm.font({ family = "Berkeley Mono Variable", weight = "Light" })
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 16
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30
config.keys = set_keys()
return config
