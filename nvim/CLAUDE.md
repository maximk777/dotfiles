# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on [LazyVim](https://lazyvim.github.io) starter template. The configuration uses lazy.nvim as the plugin manager.

## Architecture

```
~/.config/nvim/
├── init.lua              # Entry point, loads config/lazy.lua
├── lua/
│   ├── config/
│   │   ├── lazy.lua      # lazy.nvim bootstrap and plugin spec loading
│   │   ├── options.lua   # Vim options (extends LazyVim defaults)
│   │   ├── keymaps.lua   # Custom keymaps (extends LazyVim defaults)
│   │   └── autocmds.lua  # Custom autocommands
│   └── plugins/          # Plugin specifications (auto-imported)
```

## Language Support

- **Go**: LazyVim extras + ray-x/go.nvim for advanced features
- **Rust**: LazyVim extras

## Key Custom Features

### Testing (neotest)
- `<leader>tt` - Run nearest test
- `<leader>tf` - Run test file
- `<leader>ts` - Toggle test summary
- `<leader>to` - Toggle output panel

### Debugging (nvim-dap)
- `<leader>dd` - Continue/Start debug
- `<leader>dn` - Step over
- `<leader>di` - Step into
- `<leader>do` - Step out
- `<leader>db` - Toggle breakpoint
- `<leader>du` - Toggle DAP UI

### Refactoring
- `<leader>rr` - Select refactor
- `<leader>re` - Extract function (visual)
- `<leader>rf` - Extract to file (visual)
- `<leader>rv` - Extract variable (visual)
- `<leader>ri` - Inline variable

### OpenAPI/Swagger
- Auto-detects OpenAPI files (.yaml/.yml/.json with openapi/swagger keys)
- `<leader>sw` - Open current file in Swagger UI (browser)
- `<leader>sx` - Stop all Swagger servers
- `:SwaggerUI` / `:SwaggerStop` commands

### UI
- `<leader>z` - Zen mode
- `<leader>gg` - LazyGit
- `<leader>sm` - Markdown preview toggle
- Neo-tree in left sidebar (width 30)
- Kanagawa (dragon theme) colorscheme

### Split Navigation (smart-splits)
- `<C-h/j/k/l>` - Move between splits
- `<A-h/j/k/l>` - Resize splits

### Folding (nvim-ufo)
- `zR` - Open all folds
- `zM` - Close all folds

## SQL Formatting

Uses sqlfluff via conform.nvim (requires `sqlfluff` in PATH).

## Plugin Management

Add new plugins in `lua/plugins/` directory. Each file returns a table (or list of tables) with plugin specs. LazyVim auto-imports all files from this directory.
