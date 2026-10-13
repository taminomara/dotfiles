local wez = require('wezterm')

local config = wez.config_builder()

config.color_scheme = 'Catppuccin Macchiato'

require('tabs').apply_to_config(config)

require('keymap').apply_to_config(config)

config.font_size = 13
config.font = wez.font 'Cascadia Mono'
config.track_bold_and_dim_separately = true

require('remotes').apply_to_config(config)

require('links').apply_to_config(config)

return config
