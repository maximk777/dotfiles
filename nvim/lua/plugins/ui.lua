return {
  -- OneDark colorscheme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "dark",
        transparent = false,
        term_colors = true,
        code_style = {
          comments = "italic",
          keywords = "bold",
          functions = "none",
          strings = "none",
          variables = "none",
        },
        lualine = { transparent = false },
        diagnostics = {
          darker = true,
          undercurl = true,
          background = true,
        },
      })
      require("onedark").load()
    end,
  },

  -- File tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File Explorer" },
      { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal in Explorer" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
        window = {
          width = 35,
          mappings = {
            ["<space>"] = "none",
            ["<C-h>"] = "none",
            ["<C-l>"] = "none",
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added = "",
              modified = "",
              deleted = "✖",
              renamed = "󰁕",
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
        },
      })
    end,
  },

  -- Noice - better UI for messages, cmdline, popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = { enabled = true },
        signature = { enabled = false },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    },
    keys = {
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    },
  },

  -- Notify - better notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      render = "compact",
      stages = "fade",
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  -- Aerial - code outline
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Toggle Outline" },
      { "<leader>O", "<cmd>AerialNavToggle<cr>", desc = "Toggle Outline Nav" },
    },
    opts = {
      backends = { "treesitter", "lsp", "markdown", "man" },
      layout = {
        min_width = 30,
        default_direction = "right",
      },
      attach_mode = "global",
      show_guides = true,
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Struct",
        "Type",
      },
      guides = {
        mid_item = "├─",
        last_item = "└─",
        nested_top = "│ ",
        whitespace = "  ",
      },
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Prev symbol" })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Next symbol" })
      end,
    },
  },

  -- Mini.bufremove - safe buffer deletion
  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Close buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Close buffer (force)" },
    },
  },

  -- Bufferline - tabs for buffers
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.bufremove" },
    event = "VeryLazy",
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Close unpinned" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close others" },
    },
    opts = {
      options = {
        close_command = function(bufnr) require("mini.bufremove").delete(bufnr, false) end,
        right_mouse_command = function(bufnr) require("mini.bufremove").delete(bufnr, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
          {
            filetype = "aerial",
            text = "Outline",
            highlight = "Directory",
            separator = true,
          },
        },
      },
    },
  },

  -- Lualine - statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "onedark",
        globalstatus = true,
        disabled_filetypes = { statusline = { "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "neo-tree", "lazy", "aerial" },
    },
  },

  -- Improved diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    opts = {},
  },

  -- Which-key for keymaps display
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code/crates" },
        { "<leader>d", group = "debug" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git/go" },
        { "<leader>h", group = "git hunk" },
        { "<leader>n", group = "noice" },
        { "<leader>o", group = "outline" },
        { "<leader>r", group = "rust/refactor" },
        { "<leader>s", group = "search/split" },
        { "<leader>t", group = "test/terminal" },
        { "<leader>x", group = "diagnostics" },
        { "<leader>w", group = "workspace/session" },
      },
    },
  },

  -- TODO comments highlighting
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODOs (Trouble)" },
    },
    opts = {},
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },

  -- Breadcrumbs - navigation path at top
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      attach_navic = false, -- We'll attach in LSP on_attach
    },
  },

  -- Navic - LSP breadcrumb provider
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    opts = {
      lsp = { auto_attach = true },
      highlight = true,
    },
  },

  -- Illuminate - highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      -- Keymaps for navigating references
      vim.keymap.set("n", "]]", function()
        require("illuminate").goto_next_reference(false)
      end, { desc = "Next Reference" })
      vim.keymap.set("n", "[[", function()
        require("illuminate").goto_prev_reference(false)
      end, { desc = "Prev Reference" })
    end,
  },

  -- Rainbow delimiters - colored brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["global"],
          vim = rainbow.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- Colorizer - show colors in code
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = true,
        virtualtext = "■",
      },
    },
  },

  -- UFO - better code folding
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    init = function()
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- Don't save folds in session (prevents E16 errors)
      vim.opt.sessionoptions:remove("folds")
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zK", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, desc = "Peek fold" },
    },
  },
}
