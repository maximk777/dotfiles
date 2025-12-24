local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Enable inlay hints (Neovim 0.10+)
if vim.lsp.inlay_hint then
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end

    -- Navigation (using Telescope for better UI)
    local telescope = require("telescope.builtin")
    map("n", "gd", telescope.lsp_definitions, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gr", telescope.lsp_references, "Go to references")
    map("n", "gi", telescope.lsp_implementations, "Go to implementation")
    map("n", "gt", telescope.lsp_type_definitions, "Go to type definition")

    -- Hover and signatures
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Refactoring
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

    -- Diagnostics
    map("n", "gl", vim.diagnostic.open_float, "Show diagnostic")
    map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostic list")

    -- Inlay hints toggle
    if vim.lsp.inlay_hint then
      map("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
      end, "Toggle inlay hints")
    end

    -- Workspace
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
  end,
})

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = {
    prefix = "",
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

local function root(markers)
  return vim.fs.root(0, markers)
end

-- Go (gopls with enhanced settings)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    -- Skip gitsigns buffers
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("^gitsigns://") or bufname:match("^fugitive://") then
      return
    end
    vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      root_dir = root({ "go.work", "go.mod", ".git" }),
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
            nilness = true,
            unusedwrite = true,
            useany = true,
          },
          staticcheck = true,
          gofumpt = true,
          usePlaceholders = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })
  end,
})

-- Lua (lua_ls for Neovim config editing)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("^gitsigns://") or bufname:match("^fugitive://") then
      return
    end

    vim.lsp.start({
      name = "lua_ls",
      cmd = { "lua-language-server" },
      root_dir = vim.fs.root(0, { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" }),
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
            },
          },
          diagnostics = { globals = { "vim" } },
          hint = {
            enable = true,
            setType = true,
            arrayIndex = "Disable",
          },
        },
      },
    })
  end,
})

-- Rust is handled by rustaceanvim plugin
