-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

config.keys = {
    { key = "d", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },
    { key = "L", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
}

-- For example, changing the color scheme:
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 15

-- Latency tuning. Decouple input handling from the default 60fps frame
-- throttle, and stop the cursor fade animation from driving constant
-- repaints when an app (nvim insert mode) requests a blinking cursor.
config.max_fps = 120
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true
config.use_dead_keys = true
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
