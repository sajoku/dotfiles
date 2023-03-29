local wezterm = require("wezterm")

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "rose-pine-moon"
	else
		--return "Rosé Pine Dawn (base16)"
		return "rose-pine-moon"
	end
end

return {
	font = wezterm.font("MonoLisa Nerd Font"),
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
