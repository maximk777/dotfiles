# Neovim Hotkeys

> Leader key: `<Space>`

## Testing (`<leader>t`)

| Keys | Action |
|------|--------|
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run all tests in file |
| `<leader>ta` | Run all tests in project |
| `<leader>tl` | Re-run last test |
| `<leader>tr` | Run with `-race` flag (Go) |
| `<leader>td` | Debug nearest test |
| `<leader>te` | Run with environment variables |
| `<leader>tE` | Run with extra arguments |
| `<leader>ts` | Toggle summary panel |
| `<leader>to` | Toggle output panel |

### Coverage

| Keys | Action |
|------|--------|
| `<leader>tC` | Load coverage |
| `<leader>tS` | Show coverage summary |
| `<leader>tH` | Toggle coverage highlights |

---

## Debugging (`<leader>d`)

| Keys | Action |
|------|--------|
| `<leader>dd` | Start/Continue |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dL` | Log point |
| `<leader>dn` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>du` | Toggle DAP UI |
| `<leader>dr` | Toggle REPL |
| `<leader>dt` | Terminate |
| `<leader>dC` | Run to cursor |
| `<leader>dp` | Pause |
| `<leader>de` | Evaluate expression (n/v) |

---

## Refactoring (`<leader>r`)

| Keys | Mode | Action |
|------|------|--------|
| `<leader>rr` | n, x | Refactoring menu |
| `<leader>re` | x | Extract function |
| `<leader>rf` | x | Extract to file |
| `<leader>rv` | x | Extract variable |
| `<leader>ri` | n, x | Inline variable |

---

## Navigation

### Aerial (file structure)

| Keys | Action |
|------|--------|
| `<leader>cs` | Toggle outline |
| `<leader>cS` | Aerial navigation |

### Harpoon (quick bookmarks)

| Keys | Action |
|------|--------|
| `<leader>H` | Add file to Harpoon |
| `<leader>h` | Open Harpoon menu |
| `<leader>1` | Go to file 1 |
| `<leader>2` | Go to file 2 |
| `<leader>3` | Go to file 3 |
| `<leader>4` | Go to file 4 |
| `<leader>5` | Go to file 5 |

### Leap (quick jumps)

| Keys | Action |
|------|--------|
| `s` | Jump forward (type 2 chars) |
| `S` | Jump backward |
| `gs` | Jump to other window |

---

## Git

| Keys | Action |
|------|--------|
| `<leader>gg` | Open LazyGit |

---

## UI

### Zen Mode

| Keys | Action |
|------|--------|
| `<leader>z` | Focus mode |

### Split Navigation

| Keys | Action |
|------|--------|
| `<C-h>` | Move to left split |
| `<C-j>` | Move to split below |
| `<C-k>` | Move to split above |
| `<C-l>` | Move to right split |

### Split Resizing

| Keys | Action |
|------|--------|
| `<A-h>` | Decrease width |
| `<A-j>` | Increase height |
| `<A-k>` | Decrease height |
| `<A-l>` | Increase width |

### Folding

| Keys | Action |
|------|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `za` | Toggle fold |
| `zo` | Open fold |
| `zc` | Close fold |

---

## Tools

| Keys | Action |
|------|--------|
| `<leader>sm` | Markdown preview |
| `<leader>sw` | Swagger UI (OpenAPI) |
| `<leader>sx` | Stop Swagger servers |

---

## Spell Check

| Keys | Action |
|------|--------|
| `zg` | Add word to dictionary |

---

## Neo-tree (file explorer)

| Keys | Action |
|------|--------|
| `<leader>e` | Toggle Neo-tree |
| `l` | Open file/folder |
| `h` | Close folder |

---

## LazyVim (defaults)

### Buffers

| Keys | Action |
|------|--------|
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bd` | Close buffer |
| `<leader>bo` | Close other buffers |

### Search (Telescope)

| Keys | Action |
|------|--------|
| `<leader>ff` | Find file |
| `<leader>fg` | Grep in files |
| `<leader>fb` | List buffers |
| `<leader>fr` | Recent files |
| `<leader>fs` | Search symbols |

### LSP

| Keys | Action |
|------|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gI` | Go to implementation |
| `K` | Show documentation |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename |
| `<leader>cf` | Format |

### Diagnostics

| Keys | Action |
|------|--------|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<leader>cd` | Show diagnostic |

---

## Use Cases

### Go Development

1. Create `.go` file - `package` is auto-inserted
2. `<leader>tt` - run test under cursor
3. `<leader>tr` - run with race detector
4. `<leader>te` - run with env variables
5. `<leader>td` - debug test
6. `<leader>tC` - view coverage

### Debugging

1. `<leader>db` - set breakpoint
2. `<leader>dB` - conditional breakpoint (e.g. `i > 10`)
3. `<leader>dd` - start debugging
4. `<leader>dn/di/do` - step through code
5. `<leader>de` - evaluate variable
6. `<leader>dt` - terminate

### Project Navigation

1. `<leader>H` - add important files to Harpoon
2. `<leader>1-5` - quick switch between them
3. `s` + 2 chars - jump anywhere on screen
4. `<leader>cs` - function outline

### Refactoring

1. Select code in visual mode
2. `<leader>re` - extract to function
3. `<leader>rv` - extract to variable
4. `<leader>ri` - inline variable back
