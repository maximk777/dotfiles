return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqlfluff" },
      pgsql = { "sqlfluff" },
      mysql = { "sqlfluff" },
      plsql = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        prepend_args = { "format", "--dialect=postgres", "--disable-progress-bar", "--nocolor" },
        stdin = true,
        condition = function(self, ctx)
          return vim.fn.executable("sqlfluff") == 1
        end,
      },
    },
  },
}
