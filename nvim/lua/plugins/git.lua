return {
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit (popup)" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function() end,
  },
  { "lewis6991/gitsigns.nvim", config = true },
  { "sindrets/diffview.nvim", config = true },
  { "lewis6991/gitsigns.nvim", config = true },
}
