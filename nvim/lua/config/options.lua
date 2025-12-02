-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable LazyVim deprecation warnings
vim.g.lazyvim_check_deprecated = false

-- Spellchecking (disabled globally, cspell via none-ls handles code spelling)
vim.opt.spell = false
vim.opt.spelllang = { "en", "ru" }

-- Custom spellfile for personal dictionary (zg/zw commands)
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/custom.utf-8.add"

-- Enable spell only for text-based filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "plaintex" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
