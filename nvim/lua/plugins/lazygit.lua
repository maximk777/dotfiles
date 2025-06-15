return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
      -- keymap для LazyGit
      vim.keymap.set("n", "<leader>gg", function()
        require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" }):toggle()
      end, { desc = "Lazygit (float)" })
    end,
  },
}
