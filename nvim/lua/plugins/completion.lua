return {
  -- nvim-cmp sources
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "Exafunction/codeium.nvim" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "codeium" })
    end,
  },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  { "rafamadriz/friendly-snippets" },
  { "windwp/nvim-autopairs", config = true },
  { "windwp/nvim-ts-autotag", config = true },

  -- AI code suggestions
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    config = function()
      require("codeium").setup({})
    end,
  },
  {
    "augmentcode/augment.vim",
    lazy = false,
  },
}
