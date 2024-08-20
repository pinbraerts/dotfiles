local wezterm = require("wezterm")

local config = {}
local a = wezterm.action

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function tm(key, mods)
	return { key = key, mods = mods, action = a.SendKey({ key = key, mods = mods }) }
end

config.force_reverse_video_cursor = true
-- config.color_scheme = 'Vaughn'
config.color_scheme = "AdventureTime"
config.default_prog = { "powershell.exe", "-nologo" }
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.keys = {
	{ key = "\\", mods = "WIN", action = a.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "WIN", action = a.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "[", mods = "WIN", action = a.ActivatePaneDirection("Prev") },
	{ key = "]", mods = "WIN", action = a.ActivatePaneDirection("Next") },
	{ key = "Delete", mods = "WIN", action = a.CloseCurrentPane({ confirm = true }) },
	tm("Enter", "SHIFT"),
	tm("Enter", "ALT"),
	tm("Enter", "CTRL"),
	tm("Enter", "SHIFT|ALT"),
	tm("Enter", "ALT|CTRL"),
	tm("Enter", "CTRL|SHIFT"),
	tm("Enter", "SHIFT|ALT|CTRL"),
	tm("j", "CTRL"),
	tm("k", "CTRL"),
}
-- config.window_background_image = "c:/users/pinbraerts/pictures/1920x1080_samurai_tour_wallpaper.png"
-- config.window_background_image_hsb = {
--	 brightness = 0.3,
--	 hue = 1.0,
--	 saturation = 1.0,
-- }
-- config.window_background_opacity = 0.8

return config
