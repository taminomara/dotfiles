local wez = require('wezterm')
local act = wez.action

local M = {}

-- Open a hyperlink only when there is no selection, so that a click follows a
-- link but a drag-select does not. This is the no-copy half of wezterm's
-- built-in CompleteSelectionOrOpenLinkAtMouseCursor.
local open_link_only = wez.action_callback(function(window, pane)
  if window:get_selection_text_for_pane(pane) == '' then
    window:perform_action(act.OpenLinkAtMouseCursor, pane)
  end
end)

local function pane_or_tab(dir, tab_delta)
  return wez.action_callback(function(window, pane)
    if window:active_tab():get_pane_direction(dir) then
      window:perform_action(act.ActivatePaneDirection(dir), pane)
    else
      window:perform_action(act.ActivateTabRelative(tab_delta), pane)
    end
  end)
end

function M.apply_to_config(config)
  config.disable_default_key_bindings = true
  config.disable_default_mouse_bindings = true

  config.keys = {
    ------------------------------------------------------------------
    -- Copy & Paste
    ------------------------------------------------------------------
    {
      key = 'c', mods = 'CTRL',
      action = wez.action_callback(function(window, pane)
        local has_selection = window:get_selection_text_for_pane(pane) ~= ''
        if has_selection then
          window:perform_action(act.CopyTo 'Clipboard', pane)
          window:perform_action(act.ClearSelection, pane)
        else
          window:perform_action(act.SendKey { key = 'c', mods = 'CTRL' }, pane)
        end
      end),
    },
    { key = 'c', mods = 'SHIFT|CTRL',     action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'CTRL',           action = act.PasteFrom 'Clipboard', },
    { key = 'v', mods = 'SHIFT|CTRL',     action = act.PasteFrom 'Clipboard' },
    { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
    { key = 'Insert', mods = 'CTRL', action = act.CopyTo 'PrimarySelection' },
    { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },

    ------------------------------------------------------------------
    -- Esc & Clear Selection
    ------------------------------------------------------------------
    {
      key = 'Escape', mods = 'NONE',
      action = wez.action_callback(function(window, pane)
        if window:get_selection_text_for_pane(pane) ~= '' then
          window:perform_action(act.ClearSelection, pane)
        else
          window:perform_action(act.SendKey { key = 'Escape' }, pane)
        end
      end),
    },

    ------------------------------------------------------------------
    -- Command Palette
    ------------------------------------------------------------------
    { key = 'p', mods = 'SHIFT|CTRL',     action = act.ActivateCommandPalette },
    {
      key = 'p', mods = 'SHIFT|CTRL|ALT',
      action = act.ShowLauncherArgs {
        flags = 'FUZZY|DOMAINS|WORKSPACES',
        title = 'Domains & Workspaces',
      },
    },

    ------------------------------------------------------------------
    -- Tabs & Panes
    ------------------------------------------------------------------
    { key = 'Tab', mods = 'CTRL',         action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL',   action = act.ActivateTabRelative(-1) },
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
    { key = 'LeftArrow', mods = 'ALT|CTRL', action = pane_or_tab('Left', -1) },
    { key = 'RightArrow', mods = 'ALT|CTRL', action = pane_or_tab('Right', 1) },
    { key = 'UpArrow', mods = 'ALT|CTRL', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = 'ALT|CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 't', mods = 'SHIFT|CTRL|ALT', action = act.SpawnTab 'DefaultDomain' },
    { key = 't', mods = 'SHIFT|CTRL',     action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'SHIFT|CTRL',     action = act.CloseCurrentTab{ confirm = true } },
    { key = 'o', mods = 'SHIFT|CTRL', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = 'e', mods = 'SHIFT|CTRL', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    -- Rename tab
    {
      key = 'r', mods = 'CTRL|SHIFT',
      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wez.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
    -- 1 / !
    { key = '1', mods = 'ALT',            action = act.ActivateTab(0) },
    { key = '1', mods = 'SHIFT|CTRL',     action = act.ActivateTab(0) },
    { key = '!', mods = 'CTRL',           action = act.ActivateTab(0) },
    { key = '!', mods = 'SHIFT|CTRL',     action = act.ActivateTab(0) },
    -- 2 / @
    { key = '2', mods = 'ALT',            action = act.ActivateTab(1) },
    { key = '2', mods = 'SHIFT|CTRL',     action = act.ActivateTab(1) },
    { key = '@', mods = 'CTRL',           action = act.ActivateTab(1) },
    { key = '@', mods = 'SHIFT|CTRL',     action = act.ActivateTab(1) },
    -- 3 / #
    { key = '3', mods = 'ALT',            action = act.ActivateTab(2) },
    { key = '3', mods = 'SHIFT|CTRL',     action = act.ActivateTab(2) },
    { key = '#', mods = 'CTRL',           action = act.ActivateTab(2) },
    { key = '#', mods = 'SHIFT|CTRL',     action = act.ActivateTab(2) },
    -- 4 / $
    { key = '4', mods = 'ALT',            action = act.ActivateTab(3) },
    { key = '4', mods = 'SHIFT|CTRL',     action = act.ActivateTab(3) },
    { key = '$', mods = 'CTRL',           action = act.ActivateTab(3) },
    { key = '$', mods = 'SHIFT|CTRL',     action = act.ActivateTab(3) },
    -- 5 / %
    { key = '5', mods = 'ALT',            action = act.ActivateTab(4) },
    { key = '5', mods = 'SHIFT|CTRL',     action = act.ActivateTab(4) },
    { key = '%', mods = 'CTRL',           action = act.ActivateTab(4) },
    { key = '%', mods = 'SHIFT|CTRL',     action = act.ActivateTab(4) },
    -- 6 / ^
    { key = '6', mods = 'ALT',            action = act.ActivateTab(5) },
    { key = '6', mods = 'SHIFT|CTRL',     action = act.ActivateTab(5) },
    { key = '^', mods = 'CTRL',           action = act.ActivateTab(5) },
    { key = '^', mods = 'SHIFT|CTRL',     action = act.ActivateTab(5) },
    -- 7 / &
    { key = '7', mods = 'ALT',            action = act.ActivateTab(6) },
    { key = '7', mods = 'SHIFT|CTRL',     action = act.ActivateTab(6) },
    { key = '&', mods = 'CTRL',           action = act.ActivateTab(6) },
    { key = '&', mods = 'SHIFT|CTRL',     action = act.ActivateTab(6) },
    -- 8 / *
    { key = '8', mods = 'ALT',            action = act.ActivateTab(7) },
    { key = '8', mods = 'SHIFT|CTRL',     action = act.ActivateTab(7) },
    { key = '*', mods = 'CTRL',           action = act.ActivateTab(7) },
    { key = '*', mods = 'SHIFT|CTRL',     action = act.ActivateTab(7) },
    -- 9 / (   (last tab)
    { key = '9', mods = 'ALT',            action = act.ActivateTab(-1) },
    { key = '9', mods = 'SHIFT|CTRL',     action = act.ActivateTab(-1) },
    { key = '(', mods = 'CTRL',           action = act.ActivateTab(-1) },
    { key = '(', mods = 'SHIFT|CTRL',     action = act.ActivateTab(-1) },

    ------------------------------------------------------------------
    -- Other actions
    ------------------------------------------------------------------
    { key = 'f', mods = 'SHIFT|CTRL',     action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'k', mods = 'SHIFT|CTRL',     action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'n', mods = 'SHIFT|CTRL',     action = act.SpawnWindow },
    { key = 'x', mods = 'SHIFT|CTRL',     action = act.ActivateCopyMode },
    { key = 'z', mods = 'SHIFT|CTRL',     action = act.TogglePaneZoomState },
    { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
  }

  config.key_tables = {
    search_mode = {
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'r', mods = 'CTRL|SHIFT', action = act.Multiple {
          act.CopyMode 'CycleMatchType',
          act.CopyMode 'CycleMatchType',
          act.CopyMode 'CycleMatchType',
      } },
      { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },
  }

  config.mouse_bindings = {
    ------------------------------------------------------------------
    -- Wheel
    ------------------------------------------------------------------
    { event = { Down = { streak = 1, button = { WheelUp = 1 } } },   mods = 'NONE', alt_screen = false, action = act.ScrollByCurrentEventWheelDelta },
    { event = { Down = { streak = 1, button = { WheelDown = 1 } } }, mods = 'NONE', alt_screen = false, action = act.ScrollByCurrentEventWheelDelta },

    ------------------------------------------------------------------
    -- Left button down: start a selection
    ------------------------------------------------------------------
    { event = { Down = { streak = 3, button = 'Left' } }, mods = 'NONE',      action = act.SelectTextAtMouseCursor 'Line' },
    { event = { Down = { streak = 2, button = 'Left' } }, mods = 'NONE',      action = act.SelectTextAtMouseCursor 'Word' },
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'NONE',      action = act.SelectTextAtMouseCursor 'Cell' },
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'ALT',       action = act.SelectTextAtMouseCursor 'Block' },
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'SHIFT',     action = act.ExtendSelectionToMouseCursor 'Cell' },
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'ALT|SHIFT', action = act.ExtendSelectionToMouseCursor 'Block' },

    ------------------------------------------------------------------
    -- Left button up: finish the selection (and follow links)
    ------------------------------------------------------------------
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'NONE',        action = open_link_only },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'SHIFT',       action = open_link_only },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'CTRL',        action = open_link_only },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'CTRL|SHIFT',  action = open_link_only },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'ALT',         action = act.Nop },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'ALT|SHIFT',   action = act.Nop },
    { event = { Up = { streak = 2, button = 'Left' } }, mods = 'NONE',        action = act.Nop },
    { event = { Up = { streak = 3, button = 'Left' } }, mods = 'NONE',        action = act.Nop },

    ------------------------------------------------------------------
    -- Left button drag: extend the selection
    ------------------------------------------------------------------
    { event = { Drag = { streak = 1, button = 'Left' } }, mods = 'NONE', action = act.ExtendSelectionToMouseCursor 'Cell' },
    { event = { Drag = { streak = 1, button = 'Left' } }, mods = 'ALT',  action = act.ExtendSelectionToMouseCursor 'Block' },
    { event = { Drag = { streak = 2, button = 'Left' } }, mods = 'NONE', action = act.ExtendSelectionToMouseCursor 'Word' },
    { event = { Drag = { streak = 3, button = 'Left' } }, mods = 'NONE', action = act.ExtendSelectionToMouseCursor 'Line' },

    ------------------------------------------------------------------
    -- Middle button, and window dragging
    ------------------------------------------------------------------
    -- { event = { Down = { streak = 1, button = 'Middle' } }, mods = 'NONE',       action = act.PasteFrom 'PrimarySelection' },
    -- { event = { Drag = { streak = 1, button = 'Left' } },   mods = 'SHIFT|CTRL', action = act.StartWindowDrag },
  }
end

return M
