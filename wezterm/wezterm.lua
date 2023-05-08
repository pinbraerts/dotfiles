local wezterm = require 'wezterm'

local config = {}
local a = wezterm.action

if wezterm.config_builder then
  config = wezterm.config_builder()
end

function EnterMap(mods)
    return { key = "Enter", mods = mods, action = a.SendKey { key = "Enter", mods = mods } }
end

config.default_prog = { 'powershell.exe', '-nologo' }
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 12
--config.color_scheme = 'AdventureTime'
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.keys = {
    { key = "\\", mods = "WIN", action = a.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "-", mods = "WIN", action = a.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "[", mods = "WIN", action = a.ActivatePaneDirection 'Left' },
    { key = "]", mods = "WIN", action = a.ActivatePaneDirection 'Right' },
    { key = "Delete", mods = "WIN", action = a.CloseCurrentPane { confirm = true } },
    EnterMap("SHIFT"), EnterMap("ALT"), EnterMap("CTRL"),
    EnterMap("SHIFT|ALT"), EnterMap("ALT|CTRL"), EnterMap("CTRL|SHIFT"),
    EnterMap("SHIFT|ALT|CTRL"),
    --{ key = "Enter", mods = "SHIFT", action = a.SendKey { key = "Enter", mods = "SHIFT" } },
    --{ key = "Enter", mods = "ALT", action = a.SendKey { key = "Enter", mods = "ALT" } },
    --{ key = "Enter", mods = "CTRL", action = a.SendKey { key = "Enter", mods = "CTRL" } },
    --{ key = "Enter", mods = "ALT|SHIFT", action = a.SendKey { key = "Enter", mods = "ALT|SHIFT" } },
    --{ key = "Enter", mods = "ALT|CTRL", action = a.SendKey { key = "Enter", mods = "ALT|CTRL" } },
    --{ key = "Enter", mods = "ALT|CTRL|SHIFT", action = a.SendKey { key = "Enter", mods = "ALT|CTRL|SHIFT" } },
    --{ key = "Enter", mods = "CTRL|SHIFT", action = a.SendKey { key = "Enter", mods = "CTRL|SHIFT" } },
}

return config

