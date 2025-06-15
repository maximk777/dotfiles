return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- UI для дебага
      "theHamsta/nvim-dap-virtual-text", -- inline-переменные
      "leoluz/nvim-dap-go", -- Go-debugger
      "simrat39/rust-tools.nvim", -- Rust-debugger через LLDB
    },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
      require("dap-go").setup()
      -- Хоткеи для дебага (всё на <leader>d*):
      vim.keymap.set("n", "<leader>dd", function()
        require("dap").continue()
      end, { desc = "DAP Continue/Start" })
      vim.keymap.set("n", "<leader>dn", function()
        require("dap").step_over()
      end, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<leader>di", function()
        require("dap").step_into()
      end, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<leader>do", function()
        require("dap").step_out()
      end, { desc = "DAP Step Out" })
      vim.keymap.set("n", "<leader>db", function()
        require("dap").toggle_breakpoint()
      end, { desc = "DAP Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
      end, { desc = "DAP Toggle UI" })
      vim.keymap.set("n", "<leader>dr", function()
        require("dap").repl.toggle()
      end, { desc = "DAP Toggle REPL" })
    end,
  },
}
