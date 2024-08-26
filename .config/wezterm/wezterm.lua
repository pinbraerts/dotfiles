local wezterm = require("wezterm")
local a = wezterm.action
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe", "-nologo" }
end

config.colors = {
  split = "#719cd6",
}
config.force_reverse_video_cursor = true
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.5
config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.leader = { key = "q", mods = "CTRL|SHIFT" }
config.keys = {
  { key = "r", mods = "LEADER", action = a.ReloadConfiguration },
  { key = "c", mods = "LEADER", action = a.SpawnTab("CurrentPaneDomain") },
  { key = "v", mods = "LEADER", action = a.SplitHorizontal },
  { key = "s", mods = "LEADER", action = a.SplitVertical },
  { key = "n", mods = "LEADER", action = a.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = a.ActivateTabRelative(-1) },
  { key = "0", mods = "LEADER", action = a.ActivateTab(10) },
  { key = "z", mods = "LEADER", action = a.TogglePaneZoomState },
  { key = "h", mods = "LEADER", action = a.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = a.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = a.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = a.ActivatePaneDirection("Right") },
}
for i = 1, 9, 1 do
  table.insert(
    config.keys,
    { key = tostring(i), mods = "LEADER", action = a.ActivateTab(i - 1) }
  )
end

return config
