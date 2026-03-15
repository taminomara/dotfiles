local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'Default (dark) (terminal.sexy)'
config.font_size = 14
config.font = wezterm.font 'Cascadia Mono'

return config
