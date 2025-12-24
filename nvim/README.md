# Neovim Configuration

A modern Neovim setup for Go and Rust development with lazy.nvim, LSP, DAP, and extensive keybindings.

**Leader key**: `<Space>`

---

## Table of Contents

- [Quick Reference](#quick-reference)
- [Navigation](#navigation)
- [Editing](#editing)
- [LSP & Code Intelligence](#lsp--code-intelligence)
- [Git](#git)
- [Debugging](#debugging)
- [Language-Specific](#language-specific)
- [Terminal & Sessions](#terminal--sessions)
- [Vim Tips](#vim-tips)
- [Workflows](#workflows)

---

## Quick Reference

The most essential keybindings to memorize first:

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `s` | Flash jump (go anywhere fast) |
| `vaf` | Select entire function |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>e` | File explorer |
| `gcc` | Toggle comment |
| `<leader>rn` | Rename symbol |

---

## Navigation

### Basic Motions

| Key | Action |
|-----|--------|
| `h/j/k/l` | Left/Down/Up/Right |
| `w/W` | Next word/WORD start |
| `b/B` | Previous word/WORD start |
| `e/E` | Next word/WORD end |
| `0/$` | Line start/end |
| `^` | First non-blank character |
| `gg/G` | File start/end |
| `{/}` | Previous/next paragraph |
| `%` | Matching bracket |
| `H/M/L` | Screen top/middle/bottom |
| `Ctrl+u/d` | Half-page up/down |
| `Ctrl+f/b` | Full page forward/back |

### Flash Navigation (Quick Jump)

| Key | Mode | Action |
|-----|------|--------|
| `s` | Normal/Visual/Operator | Flash jump |
| `S` | Normal/Visual/Operator | Flash treesitter (structural) |
| `r` | Operator | Remote flash |
| `R` | Operator/Visual | Treesitter search |
| `Ctrl+s` | Command | Toggle flash search |

**Example**: Press `s` then type 2 characters to jump anywhere visible.

### File Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text in files) |
| `<leader>fb` | Open buffers |
| `<leader>fr` | Recent files |
| `<leader>fs` | Document symbols |
| `<leader>fS` | Workspace symbols |
| `<leader>fd` | Diagnostics |
| `<leader>fh` | Help tags |
| `<leader>/` | Search in current buffer |

**In Telescope**:
- `Ctrl+j/k` - Navigate results
- `Ctrl+q` - Send to quickfix
- `Esc` - Close

### File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>E` | Reveal current file in explorer |

**Inside Neo-tree**:
- `a` - Add file/directory
- `d` - Delete
- `r` - Rename
- `c/x/p` - Copy/Cut/Paste
- `H` - Toggle hidden files

### Buffers & Windows

| Key | Action |
|-----|--------|
| `Shift+h` | Previous buffer |
| `Shift+l` | Next buffer |
| `<leader>bd` | Close buffer |
| `<leader>bD` | Force close buffer |
| `<leader>bp` | Pin buffer |
| `<leader>bo` | Close other buffers |

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate windows |
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Equalize window sizes |
| `<leader>sx` | Close window |
| `Ctrl+Up/Down/Left/Right` | Resize windows |

### LSP Navigation

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `]]` | Next reference (illuminate) |
| `[[` | Previous reference |

### Code Outline (Aerial)

| Key | Action |
|-----|--------|
| `<leader>o` | Toggle outline |
| `<leader>O` | Toggle outline navigation |
| `{/}` | Previous/next symbol (in outline) |

---

## Editing

### Text Objects (The Power of Vim!)

Text objects work with operators like `v` (visual), `d` (delete), `c` (change), `y` (yank).

**Treesitter-powered** (AST-aware):

| Text Object | Inner | Outer | Description |
|-------------|-------|-------|-------------|
| Function | `if` | `af` | Function body / entire function |
| Class | `ic` | `ac` | Class body / entire class |
| Parameter | `ia` | `aa` | Parameter value / with separator |
| Block | `ib` | `ab` | Block contents / with braces |
| Conditional | `ii` | `ai` | If/else body / entire statement |
| Loop | `il` | `al` | Loop body / entire loop |
| Comment | - | `a/` | Entire comment |

**Git hunk**:
| Text Object | Description |
|-------------|-------------|
| `ih` | Select git hunk |

**Examples**:
- `vaf` - Select entire function
- `dif` - Delete function body
- `caa` - Change parameter (including comma)
- `yac` - Copy entire class
- `vih` - Select git hunk

### Text Object Navigation

| Key | Action |
|-----|--------|
| `]f` / `[f` | Next/prev function start |
| `]F` / `[F` | Next/prev function end |
| `]c` / `[c` | Next/prev class start |
| `]C` / `[C` | Next/prev class end |
| `]a` / `[a` | Next/prev parameter |

### Swap Parameters

| Key | Action |
|-----|--------|
| `<leader>a` | Swap with next parameter |
| `<leader>A` | Swap with previous parameter |

### Surround Operations

| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |

**Examples**:
- `ysiw"` - Surround word with quotes
- `ds'` - Delete surrounding quotes
- `cs'"` - Change single to double quotes
- `ysa{(` - Surround parameter with parentheses

### Comments

| Key | Mode | Action |
|-----|------|--------|
| `gcc` | Normal | Toggle line comment |
| `gc` | Normal/Visual | Toggle comment |
| `gbc` | Normal | Toggle block comment |
| `gb` | Normal/Visual | Toggle block comment |

### Line Operations

| Key | Mode | Action |
|-----|------|--------|
| `Alt+j` | Normal/Insert/Visual | Move line(s) down |
| `Alt+k` | Normal/Insert/Visual | Move line(s) up |
| `<` / `>` | Visual | Indent (stays in visual mode) |
| `p` | Visual | Paste without yanking replaced text |
| `J` | Normal | Join lines |

### Formatting

| Key | Mode | Action |
|-----|------|--------|
| `<leader>lf` | Normal/Visual | Format buffer/selection |

Uses: goimports (Go), rustfmt (Rust), stylua (Lua)

### Incremental Selection (Wildfire)

Press `Enter` repeatedly in visual mode to expand selection semantically.

---

## LSP & Code Intelligence

### Hover & Documentation

| Key | Mode | Action |
|-----|------|--------|
| `K` | Normal | Hover (documentation) |
| `Ctrl+k` | Insert | Signature help |

### Refactoring

| Key | Action |
|-----|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action (Normal/Visual) |

### Diagnostics

| Key | Action |
|-----|--------|
| `gl` | Show diagnostic float |
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>q` | Diagnostics to loclist |
| `<leader>xx` | Toggle diagnostics panel (Trouble) |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

### Inlay Hints

| Key | Action |
|-----|--------|
| `<leader>ih` | Toggle inlay hints |

### TODOs

| Key | Action |
|-----|--------|
| `]t` / `[t` | Next/prev TODO comment |
| `<leader>xt` | TODOs in Trouble |

### Workspace

| Key | Action |
|-----|--------|
| `<leader>wa` | Add workspace folder |
| `<leader>wr` | Remove workspace folder |
| `<leader>wl` | List workspace folders |

### Linting

| Key | Action |
|-----|--------|
| `<leader>cl` | Trigger linting |

---

## Git

### Hunk Navigation

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next/prev hunk |

### Hunk Actions

| Key | Mode | Action |
|-----|------|--------|
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hp` | Normal | Preview hunk |

### Blame

| Key | Action |
|-----|--------|
| `<leader>hb` | Blame line |
| `<leader>hB` | Blame file |
| `<leader>ht` | Toggle inline blame |

### Diff

| Key | Action |
|-----|--------|
| `<leader>hd` | Diff this |
| `<leader>hD` | Diff this ~ |
| `<leader>gd` | Open diffview |
| `<leader>gh` | File history |
| `<leader>gH` | Branch history |
| `<leader>gc` | Close diffview |

### Lazygit

| Key | Action |
|-----|--------|
| `<leader>tg` | Open Lazygit |

---

## Debugging

### Breakpoints

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |

### Execution Control

| Key | Action |
|-----|--------|
| `<leader>dc` | Continue/Start |
| `<leader>dC` | Run to cursor |
| `<leader>dg` | Go to line (skip) |
| `<leader>dl` | Run last |
| `<leader>dt` | Terminate |
| `<leader>dp` | Pause |

### Stepping

| Key | Action |
|-----|--------|
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |

### Stack Navigation

| Key | Action |
|-----|--------|
| `<leader>dj` | Down in stack |
| `<leader>dk` | Up in stack |

### Inspection

| Key | Mode | Action |
|-----|------|--------|
| `<leader>du` | Normal | Toggle DAP UI |
| `<leader>de` | Normal/Visual | Evaluate expression |
| `<leader>dr` | Normal | Toggle REPL |
| `<leader>ds` | Normal | Session picker |
| `<leader>dw` | Normal | Widgets (hover) |

---

## Language-Specific

### Go

#### Testing

| Key | Action |
|-----|--------|
| `<leader>gt` | Run tests |
| `<leader>gT` | Run test function |
| `<leader>gC` | Coverage |
| `<leader>tt` | Run nearest test (neotest) |
| `<leader>tf` | Run file tests |
| `<leader>ts` | Toggle test summary |
| `<leader>tD` | Debug nearest test |

#### Code Generation

| Key | Action |
|-----|--------|
| `<leader>gta` | Add struct tags |
| `<leader>gtr` | Remove struct tags |
| `<leader>gi` | Implement interface |
| `<leader>gf` | Fill struct |
| `<leader>ge` | Add `if err != nil` |
| `<leader>gg` | Go generate |
| `<leader>gG` | Go generate file |

#### Navigation

| Key | Action |
|-----|--------|
| `<leader>ga` | Go to alternate file (test/impl) |
| `<leader>gdo` | Go doc |

#### Modules

| Key | Action |
|-----|--------|
| `<leader>gmt` | Go mod tidy |
| `<leader>gmi` | Go mod init |

### Rust

#### Cargo/Crates (in Cargo.toml)

| Key | Action |
|-----|--------|
| `<leader>ct` | Toggle crates info |
| `<leader>cr` | Reload crates |
| `<leader>cv` | Show versions popup |
| `<leader>cf` | Show features popup |
| `<leader>cd` | Show dependencies |
| `<leader>cu` | Update crate |
| `<leader>cU` | Upgrade crate |
| `<leader>ca` | Update all |
| `<leader>cA` | Upgrade all |
| `<leader>cH` | Open homepage |
| `<leader>cR` | Open repository |
| `<leader>cD` | Open docs.rs |
| `<leader>cC` | Open crates.io |

#### Rust LSP (rustaceanvim)

| Key | Action |
|-----|--------|
| `<leader>rr` | Runnables |
| `<leader>rd` | Debuggables |
| `<leader>rm` | Expand macro |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rp` | Parent module |
| `<leader>rj` | Join lines |
| `<leader>rh` | Hover actions |
| `<leader>re` | Explain error |
| `<leader>rD` | Render diagnostic |
| `<leader>ra` | Code action |
| `<leader>rt` | Testables |

---

## Terminal & Sessions

### Toggleterm

| Key | Action |
|-----|--------|
| `Ctrl+\` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>tg` | Lazygit |

### Sessions

| Key | Action |
|-----|--------|
| `<leader>wr` | Restore session |
| `<leader>ws` | Save session |

---

## Vim Tips

### Macros

Record and replay actions:

1. `qa` - Start recording to register `a`
2. Perform actions
3. `q` - Stop recording
4. `@a` - Play macro
5. `@@` - Repeat last macro
6. `10@a` - Play macro 10 times

### Registers

| Command | Description |
|---------|-------------|
| `"ayy` | Yank line to register `a` |
| `"ap` | Paste from register `a` |
| `"+y` | Yank to system clipboard |
| `"+p` | Paste from system clipboard |
| `"0p` | Paste last yank (not delete) |
| `:reg` | Show all registers |

### Marks

| Key | Description |
|-----|-------------|
| `ma` | Set mark `a` |
| `'a` | Jump to mark `a` (line) |
| `` `a `` | Jump to mark `a` (exact position) |
| `''` | Jump to previous position |
| `:marks` | Show all marks |

**Automatic marks**:
- `` `. `` - Last change
- `` `" `` - Last exit position
- `` `[ `` / `` `] `` - Start/end of last change

### Folding

| Key | Action |
|-----|--------|
| `za` | Toggle fold |
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zK` | Peek fold preview |
| `zo/zc` | Open/close fold |

### Command-Line Tricks

| Command | Description |
|---------|-------------|
| `:!command` | Run shell command |
| `:%!sort` | Sort entire file |
| `:'<,'>!command` | Filter selection through command |
| `:r !command` | Insert command output |
| `:earlier 5m` | Undo to 5 minutes ago |
| `:later 5m` | Redo to 5 minutes from now |
| `g Ctrl+g` | Show word/char count |

### Dot Command

`.` repeats the last change. Combine with motions:

1. `ciw"hello"<Esc>` - Change word to "hello"
2. `n` - Find next occurrence
3. `.` - Repeat the change

### Global Command

`:g/pattern/command` - Execute command on matching lines:

- `:g/TODO/d` - Delete all TODO lines
- `:g/^$/d` - Delete empty lines
- `:g/error/p` - Print lines with "error"

### Search & Replace

| Command | Description |
|---------|-------------|
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |
| `:s/old/new/g` | Replace in current line |
| `*` / `#` | Search word under cursor forward/backward |
| `gn` | Select next match (for operators) |

### Visual Block Mode

`Ctrl+v` enters visual block mode:

1. `Ctrl+v` - Start block selection
2. Select columns/rows
3. `I` or `A` - Insert at start/end
4. Type text
5. `Esc` - Apply to all lines

### Useful Ex Commands

| Command | Description |
|---------|-------------|
| `:w !sudo tee %` | Save as root |
| `:e!` | Reload file (discard changes) |
| `:only` | Close all other windows |
| `:bd` | Close buffer |
| `:bufdo %s/old/new/g` | Replace in all buffers |
| `:cdo s/old/new/g` | Replace in quickfix files |

---

## Workflows

### Workflow 1: Refactoring a Function

**Scenario**: Move a function to another file and rename it.

```
1. gd            → Go to function definition
2. vaf           → Select entire function
3. d             → Delete (cut)
4. <leader>e     → Open file explorer
5. Navigate to target file, press Enter
6. p             → Paste function
7. <leader>rn    → Rename function
8. <leader>lf    → Format file
9. gr            → Check all references updated
```

### Workflow 2: Code Review

**Scenario**: Review changes in a PR.

```
1. <leader>gd    → Open diffview
2. ]c            → Jump to next change
3. <leader>hp    → Preview hunk details
4. <leader>hb    → Check who wrote this line
5. K             → Hover for documentation
6. gd            → Go to definition if needed
7. <leader>gc    → Close diffview when done
```

### Workflow 3: Debug Session

**Scenario**: Debug a failing test.

```
1. Navigate to test file
2. <leader>db    → Set breakpoint on suspicious line
3. <leader>tD    → Debug nearest test (Go) or <leader>rd (Rust)
4. <leader>di    → Step into function
5. <leader>de    → Evaluate expression to check values
6. <leader>dO    → Step over
7. <leader>du    → Toggle DAP UI for full view
8. <leader>dt    → Terminate when done
```

### Workflow 4: Search and Replace Across Project

**Scenario**: Rename a function across all files.

```
1. <leader>fg    → Live grep to find all occurrences
2. <leader>sr    → Open Spectre for search/replace
3. Enter pattern and replacement
4. Review changes
5. Apply changes
```

**Alternative with LSP**:
```
1. gd            → Go to function definition
2. <leader>rn    → LSP rename (updates all references)
```

### Workflow 5: Working with Tests (Go)

**Scenario**: Write and run tests.

```
1. Open implementation file
2. <leader>ga    → Switch to test file
3. Write test
4. <leader>gt    → Run tests
5. <leader>ts    → Toggle test summary panel
6. If fails, <leader>to to see output
7. <leader>tD    → Debug failing test
8. <leader>gC    → Check coverage
```

### Workflow 6: Exploring New Codebase

**Scenario**: Understand unfamiliar code.

```
1. <leader>e     → Browse file structure
2. <leader>fS    → Search workspace symbols
3. gd            → Jump to definitions
4. gr            → Find all references
5. K             → Read documentation
6. <leader>o     → Open outline for file structure
7. <leader>hB    → Git blame to understand history
```

### Workflow 7: Quick Edits with Text Objects

**Scenario**: Various quick editing tasks.

```
# Change function parameter:
cia           → Change inner parameter

# Wrap string in function call:
ysiw)         → Surround word with ()
i func_name   → Type function name

# Comment out block:
Vab gc        → Select block, toggle comment

# Delete entire if statement:
dai           → Delete around conditional

# Copy function to clipboard:
"+yaf         → Yank function to system clipboard
```

---

## UI Toggles

| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spell check |
| `<leader>uw` | Toggle wrap |
| `<leader>un` | Toggle line numbers |
| `<leader>uc` | Toggle colorcolumn (100) |
| `<leader>ud` | Toggle diagnostics |

---

## Which-Key

Press `<leader>` and wait to see available keybindings grouped by category:

- `b` - Buffer operations
- `c` - Code/Crates
- `d` - Debug
- `f` - Find (Telescope)
- `g` - Git/Go
- `h` - Git hunks
- `n` - Noice (notifications)
- `o` - Outline
- `r` - Rust/Refactor
- `s` - Search/Split
- `t` - Test/Terminal
- `u` - UI toggles
- `w` - Workspace/Session
- `x` - Diagnostics

---

## Plugins

This configuration uses **lazy.nvim** with the following main plugins:

- **LSP**: nvim-lspconfig, mason.nvim
- **Completion**: nvim-cmp, LuaSnip
- **Treesitter**: nvim-treesitter, nvim-treesitter-textobjects
- **Navigation**: Telescope, flash.nvim
- **Git**: gitsigns.nvim, diffview.nvim
- **UI**: neo-tree, lualine, bufferline, noice.nvim
- **Debug**: nvim-dap, nvim-dap-ui
- **Go**: go.nvim, neotest-golang
- **Rust**: rustaceanvim, crates.nvim
- **Editing**: nvim-surround, Comment.nvim, nvim-autopairs

---

*Generated for Neovim config at ~/.config/nvim*
