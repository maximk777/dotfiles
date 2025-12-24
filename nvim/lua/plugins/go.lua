return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_cfg = false,
        lsp_gofumpt = false,
        lsp_keymaps = false,

        test_runner = "go",
        run_in_floaterm = true,
        floaterm = {
          position = "bottom",
          width = 0.8,
          height = 0.4,
        },

        tag_transform = "snakecase",
        tag_options = "json=omitempty",

        icons = { breakpoint = "", currentpos = "" },

        test_coverage_sign = true,
        verbose_tests = true,
      })

      local go_keymaps = vim.api.nvim_create_augroup("GoKeymaps", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = go_keymaps,
        pattern = { "go" },
        callback = function(args)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
          end

          -- Tests
          map("n", "<leader>gt", "<cmd>GoTest<cr>", "Go Test")
          map("n", "<leader>gT", "<cmd>GoTestFunc<cr>", "Go Test Function")
          map("n", "<leader>gC", "<cmd>GoCoverage<cr>", "Go Coverage")

          -- Generation
          map("n", "<leader>gta", "<cmd>GoAddTag<cr>", "Add struct tags")
          map("n", "<leader>gtr", "<cmd>GoRmTag<cr>", "Remove struct tags")
          map("n", "<leader>gi", "<cmd>GoImpl<cr>", "Implement interface")
          map("n", "<leader>gf", "<cmd>GoFillStruct<cr>", "Fill struct")
          map("n", "<leader>ge", "<cmd>GoIfErr<cr>", "Add if err")

          -- Generate
          map("n", "<leader>gg", "<cmd>GoGenerate<cr>", "Go Generate")
          map("n", "<leader>gG", "<cmd>GoGenerate %<cr>", "Go Generate file")

          -- Navigation
          map("n", "<leader>ga", "<cmd>GoAlt<cr>", "Go to alt file (test/impl)")
          map("n", "<leader>gdo", "<cmd>GoDoc<cr>", "Go Doc")

          -- Modules
          map("n", "<leader>gmt", "<cmd>GoModTidy<cr>", "Go Mod Tidy")
          map("n", "<leader>gmi", "<cmd>GoModInit<cr>", "Go Mod Init")
        end,
      })
    end,
  },

  -- Neotest for flexible testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test" },
      { "<leader>tD", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-golang")({
            go_test_args = { "-v", "-race", "-count=1" },
          }),
        },
      })
    end,
  },
}
