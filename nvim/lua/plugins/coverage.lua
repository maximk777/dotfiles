return {
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Coverage", "CoverageLoad", "CoverageShow", "CoverageHide", "CoverageToggle", "CoverageSummary", "CoverageClear" },
    keys = {
      { "<leader>tC", "<cmd>Coverage<cr>", desc = "Coverage load" },
      { "<leader>tS", "<cmd>CoverageSummary<cr>", desc = "Coverage summary" },
      { "<leader>tH", "<cmd>CoverageToggle<cr>", desc = "Coverage toggle" },
    },
    opts = {
      auto_reload = true,
      lang = {
        go = {
          coverage_file = "coverage.out",
        },
        rust = {
          coverage_command = "grcov ${cwd} -s ${cwd} --binary-path ./target/debug/ -t coveralls --branch --ignore-not-existing --token NO_TOKEN",
          project_files_only = true,
        },
      },
      highlights = {
        covered = { fg = "#98971A" },
        uncovered = { fg = "#FB4934" },
      },
    },
  },
}
