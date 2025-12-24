vim.g.mapleader = " "

local map = vim.keymap.set

-- Basic
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Jump navigation (like JetBrains Cmd+Option+Left/Right)
map("n", "<C-o>", "<C-o>", { desc = "Jump back" })
map("n", "<C-i>", "<C-i>", { desc = "Jump forward" })
map("n", "<leader>jb", "<C-o>", { desc = "Jump back" })
map("n", "<leader>jf", "<C-i>", { desc = "Jump forward" })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window splits
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal size windows" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close window" })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search highlighting
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Paste without yanking in visual mode
map("v", "p", '"_dP', { desc = "Paste without yank" })

-- Toggle options (u = ui)
map("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Toggle spell check" })
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })
map("n", "<leader>un", "<cmd>set number! relativenumber!<cr>", { desc = "Toggle line numbers" })
map("n", "<leader>uc", function()
  if vim.wo.colorcolumn == "" then
    vim.wo.colorcolumn = "100"
  else
    vim.wo.colorcolumn = ""
  end
end, { desc = "Toggle colorcolumn" })
map("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- Toggle format on save
vim.g.autoformat = true
map("n", "<leader>uf", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify("Format on save: " .. (vim.g.autoformat and "ON" or "OFF"), vim.log.levels.INFO)
end, { desc = "Toggle format on save" })

-- Toggle inlay hints globally
map("n", "<leader>uI", function()
  local enabled = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not enabled)
  vim.notify("Inlay hints: " .. (not enabled and "ON" or "OFF"), vim.log.levels.INFO)
end, { desc = "Toggle inlay hints (global)" })
