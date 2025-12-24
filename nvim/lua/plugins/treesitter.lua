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

      -- Select textobjects with descriptions
      local select_maps = {
        { key = "af", query = "@function.outer", desc = "outer function" },
        { key = "if", query = "@function.inner", desc = "inner function" },
        { key = "ac", query = "@class.outer", desc = "outer class" },
        { key = "ic", query = "@class.inner", desc = "inner class" },
        { key = "aa", query = "@parameter.outer", desc = "outer parameter" },
        { key = "ia", query = "@parameter.inner", desc = "inner parameter" },
        { key = "ab", query = "@block.outer", desc = "outer block" },
        { key = "ib", query = "@block.inner", desc = "inner block" },
        { key = "ai", query = "@conditional.outer", desc = "outer conditional" },
        { key = "ii", query = "@conditional.inner", desc = "inner conditional" },
        { key = "al", query = "@loop.outer", desc = "outer loop" },
        { key = "il", query = "@loop.inner", desc = "inner loop" },
        { key = "a/", query = "@comment.outer", desc = "comment" },
      }
      for _, mapping in ipairs(select_maps) do
        vim.keymap.set({ "x", "o" }, mapping.key, function()
          select.select_textobject(mapping.query, "textobjects")
        end, { desc = mapping.desc })
      end

      -- Move keymaps with descriptions
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function start" })
      vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
      vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Prev function end" })
      vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
      vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class start" })
      vim.keymap.set({ "n", "x", "o" }, "]C", function() move.goto_next_end("@class.outer", "textobjects") end, { desc = "Next class end" })
      vim.keymap.set({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end, { desc = "Prev class end" })
      vim.keymap.set({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end, { desc = "Next parameter" })
      vim.keymap.set({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end, { desc = "Prev parameter" })

      -- Swap keymaps with descriptions
      vim.keymap.set("n", "<leader>a", function() swap.swap_next("@parameter.inner", "textobjects") end, { desc = "Swap next param" })
      vim.keymap.set("n", "<leader>A", function() swap.swap_previous("@parameter.inner", "textobjects") end, { desc = "Swap prev param" })
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
