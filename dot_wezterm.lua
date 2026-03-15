local wezterm = require('wezterm')

-- local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main
-- return {
--     colors = theme.colors(),
--     window_frame = theme.window_frame(), -- needed only if using fancy tab bar
-- }

local config = wezterm.config_builder()

config.color_scheme = 'Default (dark) (terminal.sexy)'

return config
