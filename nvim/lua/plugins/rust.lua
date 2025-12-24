return {
  -- Crates.nvim for Cargo.toml
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local crates = require("crates")
      crates.setup({
        popup = {
          autofocus = true,
          border = "rounded",
        },
        lsp = {
          enabled = true,
          on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            map("n", "<leader>ct", crates.toggle, "Toggle crates info")
            map("n", "<leader>cr", crates.reload, "Reload crates")

            map("n", "<leader>cv", crates.show_versions_popup, "Show versions")
            map("n", "<leader>cf", crates.show_features_popup, "Show features")
            map("n", "<leader>cd", crates.show_dependencies_popup, "Show dependencies")

            map("n", "<leader>cu", crates.update_crate, "Update crate")
            map("v", "<leader>cu", crates.update_crates, "Update selected crates")
            map("n", "<leader>ca", crates.update_all_crates, "Update all crates")
            map("n", "<leader>cU", crates.upgrade_crate, "Upgrade crate")
            map("v", "<leader>cU", crates.upgrade_crates, "Upgrade selected crates")
            map("n", "<leader>cA", crates.upgrade_all_crates, "Upgrade all crates")

            map("n", "<leader>cH", crates.open_homepage, "Open homepage")
            map("n", "<leader>cR", crates.open_repository, "Open repository")
            map("n", "<leader>cD", crates.open_documentation, "Open docs.rs")
            map("n", "<leader>cC", crates.open_crates_io, "Open crates.io")
          end,
          actions = true,
          completion = true,
          hover = true,
        },
      })

      local cmp = require("cmp")
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          cmp.setup.buffer({ sources = { { name = "crates" } } })
        end,
      })
    end,
  },

  -- rustaceanvim - modern rust-tools replacement
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            map("n", "<leader>rr", "<cmd>RustLsp runnables<cr>", "Runnables")
            map("n", "<leader>rd", "<cmd>RustLsp debuggables<cr>", "Debuggables")
            map("n", "<leader>rm", "<cmd>RustLsp expandMacro<cr>", "Expand Macro")
            map("n", "<leader>rc", "<cmd>RustLsp openCargo<cr>", "Open Cargo.toml")
            map("n", "<leader>rp", "<cmd>RustLsp parentModule<cr>", "Parent Module")
            map("n", "<leader>rj", "<cmd>RustLsp joinLines<cr>", "Join Lines")
            map("n", "<leader>rh", "<cmd>RustLsp hover actions<cr>", "Hover Actions")
            map("n", "<leader>re", "<cmd>RustLsp explainError<cr>", "Explain Error")
            map("n", "<leader>rD", "<cmd>RustLsp renderDiagnostic<cr>", "Render Diagnostic")
            map("n", "<leader>ra", "<cmd>RustLsp codeAction<cr>", "Code Action")
            map("n", "<leader>rt", "<cmd>RustLsp testables<cr>", "Testables")
          end,

          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true,
              check = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisionHints = { enable = "always", useParameterNames = true },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = "always" },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },

        dap = {
          adapter = {
            type = "server",
            port = "${port}",
            executable = {
              command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
              args = { "--port", "${port}" },
            },
          },
        },
      }
    end,
  },
}
