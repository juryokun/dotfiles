return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "vim", "lua", "vimdoc",
  --       "html", "css"
  --     },
  --   },
  -- },
  -- my settings
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
      local actions = require "telescope.actions"

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      })
      return opts
    end,
  },
  {
    "vim-denops/denops.vim",
    event = "BufRead",
  },
  {
    "lambdalisue/kensaku-search.vim",
    event = "BufRead",
    config = function()
      vim.keymap.set("c", "<C-j>", "<Plug>(kensaku-search-replace)<CR>")
    end,
  },
  {
    "lambdalisue/kensaku.vim",
    event = "BufRead",
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    --[[
      improve f,t
    --]]
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesittrr() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    --[[
      indent plugin
    --]]
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {
        chunk = {
          enable = true,
        },
        line_num = {
          enable = true,
        },
      }
    end,
  },
  {
    --[[
      Ctr-a, Ctr-x
    --]]
    "monaqa/dial.nvim",
    recommended = true,
    keys = require "configs.dial-keymaps",
    config = function()
      require "configs.dial"
    end,
  },
  {
    --[[
      Task manager
    --]]
    "google/executor.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "BufRead",
    config = function()
      require "configs.executor"
    end,
  },
  {
    --[[
      Diff
    --]]
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    --[[
      Quickfix
    --]]
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
  },
}
