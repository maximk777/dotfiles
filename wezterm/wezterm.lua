local wezterm = require 'wezterm'

-- Load modules
local keys = require 'keys'
local appearance = require 'appearance'
local workspaces = require 'workspaces'

local config = wezterm.config_builder()

-- ============ Basic Settings ============
config.initial_cols = 120
config.initial_rows = 28

-- Font settings
config.font_size = 15
config.font = wezterm.font 'JetBrains Mono'

-- Color scheme
config.color_scheme = 'Batman'

-- ============ Apply Modules ============
keys.apply(config)
appearance.apply(config)
workspaces.apply(config)

-- Setup event handlers
appearance.setup_status_bar()
appearance.setup_tab_title()

-- ============ Additional Settings ============
-- Disable annoying bell
config.audible_bell = 'Disabled'

-- Scrollback
config.scrollback_lines = 10000

-- Quick select patterns (URLs, paths, git hashes, etc.)
config.quick_select_patterns = {
  -- Git short hashes
  '[0-9a-f]{7,40}',
  -- IPv4
  '\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}',
  -- File paths
  '~?[\\w./\\-]+',
}

return config
