return {
  -- Treesitter - must load first (main branch - new API)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    priority = 1000,
    config = function()
      -- Install parsers
      local parsers = {
        "go", "gomod", "gowork", "gosum",
        "rust", "toml",
        "lua", "vim", "vimdoc", "query",
        "markdown", "markdown_inline",
        "json", "yaml",
        "dockerfile", "bash",
      }
      require("nvim-treesitter").install(parsers)

      -- Enable highlighting and indent via FileType autocmd
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- Textobjects - main branch with direct keymaps
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({})

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      -- Select textobjects
      local select_maps = {
        ["af"] = "@function.outer", ["if"] = "@function.inner",
        ["ac"] = "@class.outer", ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
        ["ab"] = "@block.outer", ["ib"] = "@block.inner",
        ["ai"] = "@conditional.outer", ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer", ["il"] = "@loop.inner",
        ["a/"] = "@comment.outer",
      }
      for key, query in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(query, "textobjects")
        end)
      end

      -- Move keymaps
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]C", function() move.goto_next_end("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end)

      -- Swap keymaps
      vim.keymap.set("n", "<leader>a", function() swap.swap_next("@parameter.inner", "textobjects") end)
      vim.keymap.set("n", "<leader>A", function() swap.swap_previous("@parameter.inner", "textobjects") end)
    end,
  },

  -- Incremental selection replacement (wildfire)
  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
}
