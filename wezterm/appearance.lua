local wezterm = require 'wezterm'

local M = {}

function M.apply(config)
  -- Use retro tab bar (more compact)
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = false
  config.hide_tab_bar_if_only_one_tab = false
  config.tab_max_width = 32

  -- Tab bar colors (dark theme matching Batman)
  config.colors = config.colors or {}
  config.colors.tab_bar = {
    background = '#1a1a2e',
    active_tab = {
      bg_color = '#4a4a6a',
      fg_color = '#f0f0f0',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#1a1a2e',
      fg_color = '#808080',
    },
    inactive_tab_hover = {
      bg_color = '#2a2a4e',
      fg_color = '#c0c0c0',
      italic = true,
    },
    new_tab = {
      bg_color = '#1a1a2e',
      fg_color = '#808080',
    },
    new_tab_hover = {
      bg_color = '#2a2a4e',
      fg_color = '#c0c0c0',
    },
  }

  -- Window appearance
  config.window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  }

  -- Inactive pane dimming
  config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7,
  }
end

-- Tab title with close button
function M.setup_tab_title()
  wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local title = tab.active_pane.title
    -- Truncate title if too long
    if #title > max_width - 6 then
      title = wezterm.truncate_right(title, max_width - 6)
    end

    if tab.is_active then
      return {
        { Background = { Color = '#4a4a6a' } },
        { Foreground = { Color = '#f0f0f0' } },
        { Attribute = { Intensity = 'Bold' } },
        { Text = ' ' .. title .. ' ' },
      }
    elseif hover then
      return {
        { Background = { Color = '#2a2a4e' } },
        { Foreground = { Color = '#c0c0c0' } },
        { Attribute = { Italic = true } },
        { Text = ' ' .. title .. ' ' },
      }
    else
      return {
        { Background = { Color = '#1a1a2e' } },
        { Foreground = { Color = '#808080' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
  end)
end

-- Status bar setup (called separately to register events)
function M.setup_status_bar()
  -- Update status bar
  wezterm.on('update-right-status', function(window, pane)
    local cells = {}

    -- Leader indicator
    local leader = ''
    if window:leader_is_active() then
      leader = ' LEADER '
    end

    -- Active workspace
    local workspace = window:active_workspace()
    table.insert(cells, workspace)

    -- Current working directory (shortened)
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then
      local cwd = ''
      if type(cwd_uri) == 'userdata' then
        cwd = cwd_uri.file_path
      else
        local slash = cwd_uri:find '/'
        if slash then
          cwd = cwd_uri:sub(slash)
        end
      end
      -- Shorten home directory
      local home = os.getenv 'HOME'
      if home and cwd:sub(1, #home) == home then
        cwd = '~' .. cwd:sub(#home + 1)
      end
      -- Truncate if too long
      if #cwd > 30 then
        cwd = '...' .. cwd:sub(-27)
      end
      table.insert(cells, cwd)
    end

    -- Date/time
    local date = wezterm.strftime '%H:%M'
    table.insert(cells, date)

    -- Battery (if available)
    for _, b in ipairs(wezterm.battery_info()) do
      local icon = ''
      if b.state_of_charge > 0.8 then
        icon = ''
      elseif b.state_of_charge > 0.5 then
        icon = ''
      elseif b.state_of_charge > 0.2 then
        icon = ''
      else
        icon = ''
      end
      table.insert(cells, string.format('%s %.0f%%', icon, b.state_of_charge * 100))
    end

    -- Build status string
    local status_bg = '#1a1a2e'
    local status_fg = '#808080'
    local accent_fg = '#f0c040'

    local elements = {}

    -- Leader indicator (left-aligned, shown via left status)
    if leader ~= '' then
      window:set_left_status(wezterm.format {
        { Background = { Color = '#f0c040' } },
        { Foreground = { Color = '#000000' } },
        { Attribute = { Intensity = 'Bold' } },
        { Text = leader },
      })
    else
      window:set_left_status ''
    end

    -- Right status
    for i, cell in ipairs(cells) do
      if i == 1 then
        -- Workspace gets accent color
        table.insert(elements, { Foreground = { Color = accent_fg } })
      else
        table.insert(elements, { Foreground = { Color = status_fg } })
      end
      table.insert(elements, { Background = { Color = status_bg } })
      table.insert(elements, { Text = ' ' .. cell .. ' ' })
      if i < #cells then
        table.insert(elements, { Foreground = { Color = '#404060' } })
        table.insert(elements, { Text = '|' })
      end
    end

    window:set_right_status(wezterm.format(elements))
  end)
end

return M
