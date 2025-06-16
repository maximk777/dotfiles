local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"FiraCode Nerd Font",
	}),
	font_size = 13.0,
	color_scheme = "Catppuccin Mocha", -- 👈 тут название схемы
	enable_tab_bar = false,
	hide_mouse_cursor_when_typing = true,
	window_decorations = "RESIZE",
	scrollback_lines = 5000,
	enable_hyperlink_rules = true,
}
