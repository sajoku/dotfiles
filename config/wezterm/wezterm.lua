local wezterm = require("wezterm")

function scheme_for_appearance(appearance)
  -- Macchiato, Frappe, Latte, Mocha
  if appearance:find("Dark") then
    return require('lua/rose-pine-moon').colors()
    --return "Catppuccin Frappe"
  else
    return require('lua/rose-pine-dawn').colors()
    --return "Catppuccin Mocha"
  end
end

local act = wezterm.action
return {
  --font = wezterm.font("MonoLisa Variable"),
  --font = wezterm.font("CommitMono"),
  font = wezterm.font("MonoLisa Variable", { stretch = 'UltraCondensed' }),
  freetype_load_flags = 'NO_HINTING', --Fix some settings specific for MonoLisa, https://github.com/wez/wezterm/issues/3919
  --font = wezterm.font("MonaSpace Neon"),
  --color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  colors = scheme_for_appearance(wezterm.gui.get_appearance()),
  hide_tab_bar_if_only_one_tab = true,
  font_size = 16,
  --line_height = 0.84,
  --
  -- ligatures test: => ==> <== != === => <=  --> <-- --> <!-- !~
  -- Or Radon Var, Krypton Var, Xenon Var
  -- font = wezterm.font('MonaSpace Neon Var'),
  -- harfbuzz_features = { 'ss01=1', 'ss02=1', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'calt=1',
  --   'dlig=1' },
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
  },
}
