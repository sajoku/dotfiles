local wezterm = require("wezterm")

function scheme_for_appearance(appearance)
  -- Macchiato, Frappe, Late, Mocha
  if appearance:find("Dark") then
    return "Catppuccin Macchiato"
    --return require('lua/rose-pine-moon').colors()
  else
    --return require('lua/rose-pine-moon').colors()
    return "Catppuccin Frappe"
  end
end

local act = wezterm.action
return {
  --font = wezterm.font("MonoLisa Variable"),
  --font = wezterm.font("CommitMono"),
  font = wezterm.font("MonoLisa Variable", { stretch = 'UltraCondensed', weight = "Light" }),
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  --colors = scheme_for_appearance(wezterm.gui.get_appearance()),
  hide_tab_bar_if_only_one_tab = true,
  font_size = 16,
  line_height = 0.84,

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
  },
}
