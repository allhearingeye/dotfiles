local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local action = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.color_scheme = 'Dracula'
config.font_size = 12.0
config.audible_bell = 'Disabled'
config.hide_tab_bar_if_only_one_tab = true
config.default_prog = {
  'pwsh.exe',
  '-nologo'
}

-- key bindings
wezterm.on("toggle-leader", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.leader then
    -- replace it with an "impossible" leader that will enver be pressed
    overrides.leader = { key = "_", mods = "CTRL" }
  else
    -- restore to the main leader
    overrides.leader = nil
  end
  window:set_config_overrides(overrides)
end)

config.leader = { key = ' ', mods = 'CTRL' }
config.keys = {
  { key = 'L', mods = 'CTRL', action = action.EmitEvent 'toggle-leader' },
  { key = 'c', mods = 'LEADER', action = action.SpawnTab 'CurrentPaneDomain' },
  { key = 'v', mods = 'LEADER', action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'LEADER', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'LEADER', action = action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = action.ActivatePaneDirection 'Right' },
  { key = 'q', mods = 'LEADER', action = action.PaneSelect { alphabet = '1234567890' } },
  { key = 'z', mods = 'LEADER', action = action.TogglePaneZoomState },
  { key = '1', mods = 'LEADER', action = action.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = action.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = action.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = action.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = action.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = action.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = action.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = action.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = action.ActivateTab(8) },
  { key = '0', mods = 'LEADER', action = action.ActivateTab(9) },
  { key = 'w', mods = 'LEADER', action = action.ShowTabNavigator },
  { key = 'Enter', mods = 'LEADER', action = action.ActivateCopyMode },
  { key = '/', mods = 'LEADER', action = action.Search {Regex = '' } },
  { key = 'J', mods = 'CTRL', action = action.ScrollByLine(1) },
  { key = 'K', mods = 'CTRL', action = action.ScrollByLine(-1) },
  { key = 'o', mods = 'LEADER', action = action.RotatePanes 'CounterClockwise' },
  { key = 'x', mods = 'LEADER', action = action.CloseCurrentPane { confirm = true } },
  { key = 'X', mods = 'LEADER', action = action.CloseCurrentTab { confirm = true } },
  { key = 'p', mods = 'CTRL', action = action.SendKey { key = 'UpArrow', mods = 'NONE' } },
  { key = 'n', mods = 'CTRL', action = action.SendKey { key = 'DownArrow', mods = 'NONE' } },
  { key = 'd', mods = 'CTRL', action = action.CloseCurrentPane { confirm = true } },
  { key = ',', mods = 'LEADER', action = action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

config.key_tables = {
  search_mode = {
    { key = 'Enter', mods = 'NONE', action = action.CopyMode 'PriorMatch' },
    { key = 'Escape', mods = 'NONE', action = action.CopyMode 'Close' },
    { key = '[', mods = 'CTRL', action = action.CopyMode 'Close' },
    { key = 'n', mods = 'CTRL', action = action.CopyMode 'NextMatch' },
    { key = 'p', mods = 'CTRL', action = action.CopyMode 'PriorMatch' },
    { key = 'r', mods = 'CTRL', action = action.CopyMode 'CycleMatchType' },
    { key = 'u', mods = 'CTRL', action = action.CopyMode 'ClearPattern' },
    { key = 'PageUp', mods = 'NONE', action = action.CopyMode 'PriorMatchPage' },
    { key = 'PageDown', mods = 'NONE', action = action.CopyMode 'NextMatchPage' },
    { key = 'UpArrow', mods = 'NONE', action = action.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = action.CopyMode 'NextMatch' },
  },
  copy_mode = {
    { key = 'Tab', mods = 'NONE', action = action.CopyMode 'MoveForwardWord' },
    { key = 'Tab', mods = 'SHIFT', action = action.CopyMode 'MoveBackwardWord' },
    { key = 'Enter', mods = 'NONE', action = action.CopyMode 'MoveToStartOfNextLine' },
    { key = 'Escape', mods = 'NONE', action = action.CopyMode 'Close' },
    { key = 'Space', mods = 'NONE', action = action.CopyMode{ SetSelectionMode =  'Cell' } },
    { key = '$', mods = 'NONE', action = action.CopyMode 'MoveToEndOfLineContent' },
    { key = '$', mods = 'SHIFT', action = action.CopyMode 'MoveToEndOfLineContent' },
    { key = ',', mods = 'NONE', action = action.CopyMode 'JumpReverse' },
    { key = '0', mods = 'NONE', action = action.CopyMode 'MoveToStartOfLine' },
    { key = ';', mods = 'NONE', action = action.CopyMode 'JumpAgain' },
    { key = 'F', mods = 'NONE', action = action.CopyMode{ JumpBackward = { prev_char = false } } },
    { key = 'F', mods = 'SHIFT', action = action.CopyMode{ JumpBackward = { prev_char = false } } },
    { key = 'G', mods = 'NONE', action = action.CopyMode 'MoveToScrollbackBottom' },
    { key = 'G', mods = 'SHIFT', action = action.CopyMode 'MoveToScrollbackBottom' },
    { key = 'H', mods = 'NONE', action = action.CopyMode 'MoveToViewportTop' },
    { key = 'H', mods = 'SHIFT', action = action.CopyMode 'MoveToViewportTop' },
    { key = 'L', mods = 'NONE', action = action.CopyMode 'MoveToViewportBottom' },
    { key = 'L', mods = 'SHIFT', action = action.CopyMode 'MoveToViewportBottom' },
    { key = 'M', mods = 'NONE', action = action.CopyMode 'MoveToViewportMiddle' },
    { key = 'M', mods = 'SHIFT', action = action.CopyMode 'MoveToViewportMiddle' },
    { key = 'O', mods = 'NONE', action = action.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'O', mods = 'SHIFT', action = action.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'T', mods = 'NONE', action = action.CopyMode{ JumpBackward = { prev_char = true } } },
    { key = 'T', mods = 'SHIFT', action = action.CopyMode{ JumpBackward = { prev_char = true } } },
    { key = 'V', mods = 'NONE', action = action.CopyMode{ SetSelectionMode =  'Line' } },
    { key = 'V', mods = 'SHIFT', action = action.CopyMode{ SetSelectionMode =  'Line' } },
    { key = '^', mods = 'NONE', action = action.CopyMode 'MoveToStartOfLineContent' },
    { key = '^', mods = 'SHIFT', action = action.CopyMode 'MoveToStartOfLineContent' },
    { key = 'b', mods = 'NONE', action = action.CopyMode 'MoveBackwardWord' },
    { key = 'b', mods = 'ALT', action = action.CopyMode 'MoveBackwardWord' },
    { key = 'b', mods = 'CTRL', action = action.CopyMode 'PageUp' },
    { key = 'c', mods = 'CTRL', action = action.CopyMode 'Close' },
    { key = 'd', mods = 'CTRL', action = action.CopyMode{ MoveByPage = (0.5) } },
    { key = 'e', mods = 'NONE', action = action.CopyMode 'MoveForwardWordEnd' },
    { key = 'f', mods = 'NONE', action = action.CopyMode{ JumpForward = { prev_char = false } } },
    { key = 'f', mods = 'ALT', action = action.CopyMode 'MoveForwardWord' },
    { key = 'f', mods = 'CTRL', action = action.CopyMode 'PageDown' },
    { key = 'g', mods = 'NONE', action = action.CopyMode 'MoveToScrollbackTop' },
    { key = 'g', mods = 'CTRL', action = action.CopyMode 'Close' },
    { key = 'h', mods = 'NONE', action = action.CopyMode 'MoveLeft' },
    { key = 'j', mods = 'NONE', action = action.CopyMode 'MoveDown' },
    { key = 'k', mods = 'NONE', action = action.CopyMode 'MoveUp' },
    { key = 'l', mods = 'NONE', action = action.CopyMode 'MoveRight' },
    { key = 'm', mods = 'ALT', action = action.CopyMode 'MoveToStartOfLineContent' },
    { key = 'o', mods = 'NONE', action = action.CopyMode 'MoveToSelectionOtherEnd' },
    { key = 'q', mods = 'NONE', action = action.CopyMode 'Close' },
    { key = 't', mods = 'NONE', action = action.CopyMode{ JumpForward = { prev_char = true } } },
    { key = 'u', mods = 'CTRL', action = action.CopyMode{ MoveByPage = (-0.5) } },
    { key = 'v', mods = 'NONE', action = action.CopyMode{ SetSelectionMode =  'Cell' } },
    { key = 'v', mods = 'CTRL', action = action.CopyMode{ SetSelectionMode =  'Block' } },
    { key = 'w', mods = 'NONE', action = action.CopyMode 'MoveForwardWord' },
    { key = 'y', mods = 'NONE', action = action.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
    { key = 'PageUp', mods = 'NONE', action = action.CopyMode 'PageUp' },
    { key = 'PageDown', mods = 'NONE', action = action.CopyMode 'PageDown' },
    { key = 'End', mods = 'NONE', action = action.CopyMode 'MoveToEndOfLineContent' },
    { key = 'Home', mods = 'NONE', action = action.CopyMode 'MoveToStartOfLine' },
    { key = 'LeftArrow', mods = 'NONE', action = action.CopyMode 'MoveLeft' },
    { key = 'LeftArrow', mods = 'ALT', action = action.CopyMode 'MoveBackwardWord' },
    { key = 'RightArrow', mods = 'NONE', action = action.CopyMode 'MoveRight' },
    { key = 'RightArrow', mods = 'ALT', action = action.CopyMode 'MoveForwardWord' },
    { key = 'UpArrow', mods = 'NONE', action = action.CopyMode 'MoveUp' },
    { key = 'DownArrow', mods = 'NONE', action = action.CopyMode 'MoveDown' },
    { key = 'J', mods = 'NONE', action = action.ScrollByLine(1) },
    { key = 'K', mods = 'NONE', action = action.ScrollByLine(-1) },
    { key = 'd', mods = 'CTRL', action = action.ScrollByPage(0.5) },
    { key = 'u', mods = 'CTRL', action = action.ScrollByPage(-0.5) },
  },
}

return config
