local wez = require('wezterm')

local bar = wez.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- package.path = package.path .. ";/home/taminomara/p/bar.wezterm/plugin/?.lua"
-- local bar = require "init"

local M = {}

---the scheme's own background, read from the scheme file so it is known at
---config time (custom schemes in colors/ are not in get_builtin_schemes)
---@param config table
---@return string
local function scheme_background(config)
  local name = config.color_scheme
  local builtin = name and wez.color.get_builtin_schemes()[name]
  if builtin then
    return builtin.background
  end
  local ok, scheme = pcall(wez.color.load_scheme, wez.config_dir .. '/colors/' .. name .. '.toml')
  if ok and scheme and scheme.background then
    return scheme.background
  end
  return wez.color.get_default_colors().background
end

function M.apply_to_config(config)
  -- the tab bar is painted in the window's own background color, fully
  -- opaque: cells with an explicit (non-transparent) background ignore
  -- window_background_opacity, so this keeps the bar solid while the rest
  -- of the window stays translucent.
  local bar_bg = scheme_background(config)

  bar.apply_to_config(
    config,
    {
      position = "top",
      padding = {
        left = 1,
        right = 1,
        tabs = {
          left = 1,
          right = 1,
        },
      },
      separator = {
        space = 1,
        left_icon = wez.nerdfonts.md_tab,
      },
      modules = {
        tabs = {
          active_tab_fg = 1,
          active_tab_bg = 6,
          inactive_tab_fg = 6,
          inactive_tab_bg = bar_bg,
          new_tab_fg = 2,
          new_tab_bg = bar_bg,
          rules = {
            {
              domain = "local",
              cwd = { pattern = "^/home/taminomara/p/cl/" },
              active_tab_bg = 5,
              inactive_tab_fg = 5,
              icon = wez.nerdfonts.md_rocket_launch,
            },
            {
              domain = "cl.vm",
              active_tab_bg = 7,
              inactive_tab_fg = 7,
              icon = wez.nerdfonts.md_remote_desktop,
            },
            {
              domain = { pattern = "^SSH" },
              active_tab_bg = 2,
              inactive_tab_fg = 2,
              icon = wez.nerdfonts.md_ssh,
            },
          }
        },
        workspace = {
          enabled = true,
          icon = wez.nerdfonts.cod_window,
          color = 8,
        },
        leader = {
          enabled = false,
        },
        zoom = {
          enabled = false,
        },
        pane = {
          enabled = false,
          icon = wez.nerdfonts.cod_multiple_windows,
          color = 7,
        },
        username = {
          enabled = false,
        },
        hostname = {
          enabled = false,
        },
        clock = {
          enabled = false,
        },
        cwd = {
          enabled = false,
        },
        ssh = {
          enabled = true,
          icon = wez.nerdfonts.md_ssh,
          color = 5,
        },
        spotify = {
          enabled = false,
        },
      },
    }
  )

  -- bar.wezterm hardcodes tab_bar.background = "transparent" and re-applies
  -- it through config overrides on every reload, so set ours both here and
  -- in a handler registered after the plugin's (handlers run in order).
  config.colors = config.colors or {}
  config.colors.tab_bar = config.colors.tab_bar or {}
  config.colors.tab_bar.background = bar_bg

  wez.on("window-config-reloaded", function(window, _)
    local overrides = window:get_config_overrides() or {}
    local tab_bar = overrides.colors and overrides.colors.tab_bar
    if not tab_bar or tab_bar.background == bar_bg then
      return
    end
    tab_bar.background = bar_bg
    window:set_config_overrides(overrides)
  end)
end

return M
