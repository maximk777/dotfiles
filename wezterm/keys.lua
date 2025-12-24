local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

function M.apply(config)
  -- Leader key: CTRL+A (like tmux)
  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

  config.keys = {
    -- Send CTRL+A to terminal when pressing CTRL+A twice
    {
      key = 'a',
      mods = 'LEADER|CTRL',
      action = act.SendKey { key = 'a', mods = 'CTRL' },
    },

    -- ============ Pane Management ============
    -- Split panes
    {
      key = '|',
      mods = 'LEADER|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '-',
      mods = 'LEADER',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Navigate panes (vim-style hjkl)
    {
      key = 'h',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Right',
    },

    -- Resize panes (vim-style HJKL)
    {
      key = 'H',
      mods = 'LEADER|SHIFT',
      action = act.AdjustPaneSize { 'Left', 5 },
    },
    {
      key = 'J',
      mods = 'LEADER|SHIFT',
      action = act.AdjustPaneSize { 'Down', 5 },
    },
    {
      key = 'K',
      mods = 'LEADER|SHIFT',
      action = act.AdjustPaneSize { 'Up', 5 },
    },
    {
      key = 'L',
      mods = 'LEADER|SHIFT',
      action = act.AdjustPaneSize { 'Right', 5 },
    },

    -- Toggle pane zoom
    {
      key = 'z',
      mods = 'LEADER',
      action = act.TogglePaneZoomState,
    },

    -- Close pane
    {
      key = 'x',
      mods = 'LEADER',
      action = act.CloseCurrentPane { confirm = true },
    },

    -- ============ Tab Management ============
    -- New tab
    {
      key = 'c',
      mods = 'LEADER',
      action = act.SpawnTab 'CurrentPaneDomain',
    },

    -- Close tab (quick)
    {
      key = 'q',
      mods = 'LEADER',
      action = act.CloseCurrentTab { confirm = false },
    },
    -- Close tab (with confirm, old binding)
    {
      key = '&',
      mods = 'LEADER|SHIFT',
      action = act.CloseCurrentTab { confirm = true },
    },

    -- Next/prev tab
    {
      key = 'n',
      mods = 'LEADER',
      action = act.ActivateTabRelative(1),
    },
    {
      key = 'p',
      mods = 'LEADER',
      action = act.ActivateTabRelative(-1),
    },

    -- Rename tab
    {
      key = ',',
      mods = 'LEADER',
      action = act.PromptInputLine {
        description = 'Enter new tab name:',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },

    -- ============ Workspaces ============
    -- Workspace launcher (fuzzy)
    {
      key = 'w',
      mods = 'LEADER',
      action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },

    -- Create new workspace (prompt)
    {
      key = 'W',
      mods = 'LEADER|SHIFT',
      action = act.PromptInputLine {
        description = wezterm.format {
          { Attribute = { Intensity = 'Bold' } },
          { Foreground = { AnsiColor = 'Fuchsia' } },
          { Text = 'Enter name for new workspace:' },
        },
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:perform_action(
              act.SwitchToWorkspace { name = line },
              pane
            )
          end
        end),
      },
    },

    -- Prev/next workspace
    {
      key = '[',
      mods = 'LEADER',
      action = act.SwitchWorkspaceRelative(-1),
    },
    {
      key = ']',
      mods = 'LEADER',
      action = act.SwitchWorkspaceRelative(1),
    },

    -- ============ Quick Select & Copy ============
    -- Quick select mode
    {
      key = 'Space',
      mods = 'LEADER',
      action = act.QuickSelect,
    },

    -- Copy mode (vim-style)
    {
      key = 'v',
      mods = 'LEADER',
      action = act.ActivateCopyMode,
    },

    -- ============ Utilities ============
    -- Command palette
    {
      key = ':',
      mods = 'LEADER|SHIFT',
      action = act.ActivateCommandPalette,
    },

    -- Reload config
    {
      key = 'r',
      mods = 'LEADER',
      action = act.ReloadConfiguration,
    },

    -- Search
    {
      key = '/',
      mods = 'LEADER',
      action = act.Search { CaseSensitiveString = '' },
    },

    -- Fullscreen toggle
    {
      key = 'f',
      mods = 'LEADER',
      action = act.ToggleFullScreen,
    },
  }

  -- Switch to tab 1-9 with Leader + number
  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'LEADER',
      action = act.ActivateTab(i - 1),
    })
  end

  -- Mouse bindings for tabs
  config.mouse_bindings = {
    -- Middle click on tab bar to close tab
    {
      event = { Up = { streak = 1, button = 'Middle' } },
      mods = 'NONE',
      action = act.CloseCurrentTab { confirm = false },
    },
  }
end

return M
