return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "zbirenbaum/copilot-cmp",
    },
    opts = function(_, opts)
      opts.sources = {
        { name = "nvim_lsp", group_index = 1 },
        { name = "copilot", group_index = 2 },
        { name = "buffer" },
        { name = "path" },
      }
    end,
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = false },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "rafamadriz/friendly-snippets" },
  { "windwp/nvim-autopairs", config = true },
  { "windwp/nvim-ts-autotag", config = true },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = true,
  },
}
