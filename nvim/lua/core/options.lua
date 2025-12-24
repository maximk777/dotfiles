local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- UI
opt.signcolumn = "yes"
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false -- hidden because of lualine
opt.laststatus = 3 -- global statusline

-- Disable default intro
opt.shortmess:append("sI")

-- Timing
opt.updatetime = 200
opt.timeoutlen = 300

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Tabs & indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Misc
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.wrap = false
opt.fillchars = { eob = " " }

-- Disable some builtin providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Spell check (toggle with <leader>us)
opt.spell = false -- off by default, toggle when needed
opt.spelllang = { "en", "ru" }

-- Color column (line length indicator)
opt.colorcolumn = "100"

-- Filetype-specific indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false -- Go uses tabs
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true -- Rust uses 4 spaces
  end,
})
