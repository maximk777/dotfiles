return {
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    config = function()
      require("codeium").setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "Exafunction/codeium.nvim" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "codeium" })
    end,
  },
}
