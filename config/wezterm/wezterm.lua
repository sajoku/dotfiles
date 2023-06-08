local wezterm = require("wezterm")

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Frappe"
	end
end

return {
	font = wezterm.font("MonoLisa Custom"),
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
	hide_tab_bar_if_only_one_tab = true,

	keys = {
		{
			key = "n",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
}
