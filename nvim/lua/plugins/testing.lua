return {
  { "fredrikaverpil/neotest-golang" },
  { "rouge8/neotest-rust" },
  { "nvim-neotest/neotest-python" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>t", "", desc = "+test" },
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test file" },
      { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
      { "<leader>tr", function() require("neotest").run.run({ extra_args = { "-race" } }) end, desc = "Run with -race" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
      { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      {
        "<leader>te",
        function()
          local env_input = vim.fn.input("ENV (KEY=VAL KEY2=VAL2 ...): ")
          if env_input == "" then return end
          local env = {}
          for pair in env_input:gmatch("%S+") do
            local k, v = pair:match("([^=]+)=(.+)")
            if k then env[k] = v end
          end
          require("neotest").run.run({ env = env })
        end,
        desc = "Run with env",
      },
      {
        "<leader>tE",
        function()
          local args_input = vim.fn.input("Extra args (e.g. -tags=integration -timeout=5m): ")
          if args_input == "" then return end
          local args = {}
          for arg in args_input:gmatch("%S+") do
            table.insert(args, arg)
          end
          require("neotest").run.run({ extra_args = args })
        end,
        desc = "Run with extra args",
      },
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true,
        },
        ["neotest-rust"] = {},
        ["neotest-python"] = {},
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          if require("lazyvim.util").has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
    },
  },
}
