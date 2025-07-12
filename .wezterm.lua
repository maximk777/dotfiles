local wezterm = require("wezterm")
local act = wezterm.action

return {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"FiraCode Nerd Font",
	}),
	font_size = 13.0,
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	hide_mouse_cursor_when_typing = true,
	window_decorations = "RESIZE",
	scrollback_lines = 5000,

	unix_domains = {
		{ name = "unix" },
	},

	default_gui_startup_args = { "connect", "unix" }, -- :contentReference[oaicite:0]{index=0}

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }, -- :contentReference[oaicite:1]{index=1}
	keys = {
		{ key = "d", mods = "LEADER", action = act.DetachDomain("CurrentPaneDomain") },
		{ key = "r", mods = "LEADER", action = act.AttachDomain("unix") },
		{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	},
}
