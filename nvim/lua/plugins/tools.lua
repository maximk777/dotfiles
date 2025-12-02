return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = { "markdown" },
    keys = {
      { "<leader>sm", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown Preview (toggle)" },
    },
  },
  { "numToStr/Comment.nvim", config = true },
  { "folke/todo-comments.nvim", config = true },
  { "axieax/urlview.nvim", cmd = "UrlView", config = true },
}
