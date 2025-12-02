-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-insert package declaration for new Go files (like JetBrains)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.go",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)

    -- Only insert if buffer is empty (new file)
    if #lines == 1 and lines[1] == "" then
      local filename = vim.fn.expand("%:t")
      -- Skip _test.go files - they get package from other files
      if filename:match("_test%.go$") then
        return
      end

      local dir = vim.fn.expand("%:p:h:t")
      local pkg = dir:gsub("-", "_"):gsub("[^%w_]", "")
      if pkg == "" or pkg:match("^%d") then
        pkg = "main"
      end

      local filepath = vim.fn.expand("%:p")
      if filepath:match("/cmd/") or filename == "main.go" then
        pkg = "main"
      end

      vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { "package " .. pkg, "" })
      -- Move cursor to end of file
      vim.cmd("normal! G")
    end
  end,
})

-- Auto-detect OpenAPI files and show notification
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.yaml", "*.yml", "*.json" },
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, 50, false)
    local content = table.concat(lines, "\n")

    -- Check if it's an OpenAPI file
    if
      content:match("openapi:")
      or content:match("swagger:")
      or content:match('"openapi"')
      or content:match('"swagger"')
    then
      vim.notify("OpenAPI file detected! Use <leader>sw to open in Swagger UI", vim.log.levels.INFO)

      -- Set filetype for better syntax highlighting
      vim.bo.filetype = vim.bo.filetype .. ".openapi"
    end
  end,
})
