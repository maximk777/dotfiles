local cspell_config_path = vim.fn.expand("~/.config/cspell/cspell.json")

local function add_word_to_cspell_dict()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    vim.notify("No word under cursor", vim.log.levels.WARN)
    return
  end

  local config_dir = vim.fn.expand("~/.config/cspell")
  vim.fn.mkdir(config_dir, "p")

  local config = {}
  local file = io.open(cspell_config_path, "r")
  if file then
    local content = file:read("*a")
    file:close()
    if content ~= "" then
      config = vim.json.decode(content) or {}
    end
  end

  config.words = config.words or {}
  if not vim.tbl_contains(config.words, word) then
    table.insert(config.words, word)
    table.sort(config.words)
  end

  file = io.open(cspell_config_path, "w")
  if file then
    file:write(vim.json.encode(config))
    file:close()
    vim.notify(string.format("Added '%s' to cspell dictionary", word), vim.log.levels.INFO)

    local bufnr = vim.api.nvim_get_current_buf()
    local null_ls_ok, null_ls = pcall(require, "null-ls")
    if null_ls_ok then
      vim.defer_fn(function()
        vim.diagnostic.reset(nil, bufnr)
        vim.cmd("edit")
      end, 100)
    end
  end
end

local cspell_config = {
  cspell_config_dirs = { "~/.config/cspell/" },
  config_file_preferred_name = "cspell.json",
  read_config_synchronously = true,
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = { enabled = false },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "davidmh/cspell.nvim",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      local cspell = require("cspell")
      opts.sources = opts.sources or {}
      table.insert(
        opts.sources,
        cspell.diagnostics.with({
          config = cspell_config,
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        })
      )
      table.insert(opts.sources, cspell.code_actions.with({ config = cspell_config }))
    end,
    keys = {
      { "zg", add_word_to_cspell_dict, desc = "Add word to cspell dictionary" },
    },
  },
}
