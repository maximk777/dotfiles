return {
  -- Telescope - fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
          },
          lsp_document_symbols = {
            symbol_width = 50,
            symbol_type_width = 12,
            show_line = true,
          },
          lsp_workspace_symbols = {
            symbol_width = 50,
            symbol_type_width = 12,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- Gitsigns - git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
      },
      current_line_blame_formatter = "<author>, <author_time:%d.%m.%Y> - <summary>",
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hB", "<cmd>Gitsigns blame<cr>", "Blame file")
        map("n", "<leader>ht", gs.toggle_current_line_blame, "Toggle inline blame")
        map("n", "<leader>hd", gs.diffthis, "Diff this")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- Integration with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Auto-detect indentation
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      auto_cmd = true,
      filetype_exclude = { "neo-tree", "help", "dashboard" },
    },
  },

  -- Comment.nvim
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle line" },
      { "gc", mode = { "n", "v" }, desc = "Comment toggle" },
      { "gbc", mode = "n", desc = "Comment toggle block" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle block" },
    },
    opts = {},
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Flash - quick navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Toggleterm - integrated terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", desc = "Toggle terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "Horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical terminal" },
      { "<leader>tg", function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
        lazygit:toggle()
      end, desc = "Lazygit" },
    },
    opts = {
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
      highlights = {
        FloatBorder = { link = "FloatBorder" },
      },
    },
  },

  -- Spectre - search and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>sr", function() require("spectre").toggle() end, desc = "Search & Replace" },
      { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search word" },
      { "<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Search in file" },
    },
    opts = {
      open_cmd = "noswapfile vnew",
    },
  },

  -- Diffview - git diff viewer
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
  },

  -- Auto-session - session management
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      log_level = "error",
      suppressed_dirs = { "~/", "~/Downloads", "/" },
      auto_save = true,
      auto_restore = true,
      use_git_branch = true,
      bypass_save_filetypes = { "neo-tree", "alpha", "aerial", "Trouble", "help", "qf", "gitcommit" },
      pre_save_cmds = { "Neotree close", "cclose", "lclose" },
      post_restore_cmds = { "Neotree show" },
      session_lens = {
        load_on_setup = false,
      },
    },
    keys = {
      { "<leader>wr", "<cmd>AutoSession restore<cr>", desc = "Restore session" },
      { "<leader>ws", "<cmd>AutoSession save<cr>", desc = "Save session" },
    },
  },
}
