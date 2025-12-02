# macOS Dependencies for Neovim Config

## Required

### Neovim
```bash
brew install neovim
```

### Node.js (for LSP servers and cspell)
```bash
brew install node
```

### Git
```bash
brew install git
```

---

## Language Support

### Go
```bash
brew install go
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
```

### Rust
```bash
brew install rustup
rustup-init
rustup component add rust-analyzer
```

---

## Spell Checking (cspell)
```bash
npm install -g cspell
npm install -g @cspell/dict-ru_ru
cspell link add @cspell/dict-ru_ru
```

---

## Formatters & Linters

### SQL (sqlfluff)
```bash
pip install sqlfluff
# or
brew install sqlfluff
```

### Prettier (JS/TS/JSON/YAML)
```bash
npm install -g prettier
```

### ESLint (JS/TS)
```bash
npm install -g eslint
```

---

## Debug Adapters

### Go (delve)
```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

### Rust (codelldb)
Installed automatically via Mason in Neovim:
```
:MasonInstall codelldb
```

---

## Utilities

### ripgrep (fast search)
```bash
brew install ripgrep
```

### fd (fast find)
```bash
brew install fd
```

### lazygit (Git TUI)
```bash
brew install lazygit
```

### fzf (fuzzy finder)
```bash
brew install fzf
```

---

## Fonts (Nerd Fonts for icons)
```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
# or
brew install --cask font-hack-nerd-font
```

---

## Quick Install (all at once)

```bash
# Homebrew packages
brew install neovim node git go ripgrep fd lazygit fzf

# Rust
brew install rustup && rustup-init

# Node packages
npm install -g cspell @cspell/dict-ru_ru prettier eslint
cspell link add @cspell/dict-ru_ru

# Go tools
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest

# Python packages
pip install sqlfluff

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

---

## Verify Installation

```bash
# Check versions
nvim --version
node --version
go version
rustc --version
cspell --version
rg --version
fd --version
lazygit --version
```

---

## After Installation

1. Open Neovim: `nvim`
2. Wait for lazy.nvim to install plugins
3. Run `:Mason` to check/install LSP servers
4. Run `:checkhealth` to verify everything works
