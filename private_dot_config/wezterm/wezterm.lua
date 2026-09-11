local wez = require('wezterm')

local config = wez.config_builder()

config.color_scheme = 'Catppuccin Macchiato'

require('tabs').apply_to_config(config)

require('keymap').apply_to_config(config)

config.font_size = 15
config.font = wez.font 'Cascadia Mono'
config.font_rules = {
  {
    intensity = 'Half',
    italic = false,
    font = wez.font {
      family = 'Cascadia Mono',
      weight = 'Thin',
    },
  },
  {
    intensity = 'Half',
    italic = true,
    font = wez.font {
      family = 'Cascadia Mono',
      weight = 'Thin',
      style = 'Italic',
    },
  },
}

require('remotes').apply_to_config(config)

return config
