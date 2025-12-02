return {
  -- Disable package-comments warning in gopls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                ST1000 = false, -- package comments
              },
            },
          },
        },
      },
    },
  },

  -- Advanced Go support
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- Refactoring support
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      prompt_func_return_type = {
        go = false,
      },
      prompt_func_param_type = {
        go = false,
      },
    },
    keys = {
      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "x" },
        desc = "Refactor",
      },
      {
        "<leader>re",
        ":Refactor extract ",
        mode = "x",
        desc = "Extract function",
      },
      {
        "<leader>rf",
        ":Refactor extract_to_file ",
        mode = "x",
        desc = "Extract to file",
      },
      {
        "<leader>rv",
        ":Refactor extract_var ",
        mode = "x",
        desc = "Extract variable",
      },
      {
        "<leader>ri",
        ":Refactor inline_var",
        mode = { "n", "x" },
        desc = "Inline variable",
      },
    },
  },
}
