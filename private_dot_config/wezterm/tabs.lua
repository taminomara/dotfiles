local wez = require('wezterm')

--local bar = wez.plugin.require("https://github.com/adriankarlen/bar.wezterm")
package.path = package.path .. ";/home/taminomara/p/bar.wezterm/plugin/?.lua"
local bar = require "init"

local M = {}

function M.apply_to_config(config)
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
          active_tab_fg = "transparent",
          active_tab_bg = 6,
          inactive_tab_fg = 6,
          inactive_tab_bg = "transparent",
          new_tab_fg = 2,
          new_tab_bg = "transparent",
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
end

return M
