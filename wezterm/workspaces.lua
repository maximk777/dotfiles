local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

-- Predefined workspaces with their directories
M.workspaces = {
  { id = wezterm.home_dir, label = 'Home' },
  { id = wezterm.home_dir .. '/Projects', label = 'Projects' },
  { id = wezterm.home_dir .. '/.config', label = 'Config' },
}

-- Add workspace switcher key (CTRL+SHIFT+S)
function M.apply(config)
  config.keys = config.keys or {}

  -- Quick workspace switcher with predefined workspaces
  table.insert(config.keys, {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action_callback(function(window, pane)
      local workspaces = {}
      for _, ws in ipairs(M.workspaces) do
        table.insert(workspaces, { id = ws.id, label = ws.label })
      end

      window:perform_action(
        act.InputSelector {
          action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
            if not id and not label then
              return
            end
            inner_window:perform_action(
              act.SwitchToWorkspace {
                name = label,
                spawn = {
                  label = 'Workspace: ' .. label,
                  cwd = id,
                },
              },
              inner_pane
            )
          end),
          title = 'Switch Workspace',
          choices = workspaces,
          fuzzy = true,
          fuzzy_description = 'Select or create workspace:',
        },
        pane
      )
    end),
  })
end

-- Setup startup workspaces (optional)
function M.setup_startup()
  wezterm.on('gui-startup', function(cmd)
    local args = {}
    if cmd then
      args = cmd.args
    end

    local mux = wezterm.mux

    -- Create default workspace
    local tab, pane, window = mux.spawn_window {
      workspace = 'default',
      cwd = wezterm.home_dir,
      args = args,
    }

    -- Activate default workspace
    mux.set_active_workspace 'default'
  end)
end

return M
