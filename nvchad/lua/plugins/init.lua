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
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},

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
    "monaqa/dial.nvim",
    recommended = true,
    keys = {
      {
        "<C-a>",
        function()
          return require("dial.map").manipulate("increment", "normal")
        end,
        desc = "Increment",
        mode = { "n", "v" },
      },
      {
        "<C-x>",
        function()
          return require("dial.map").manipulate("decrement", "normal")
        end,
        desc = "Decrement",
        mode = { "n", "v" },
      },
      {
        "g<C-a>",
        function()
          return require("dial.map").manipulate("increment", "normal")
        end,
        desc = "Increment",
        mode = { "n", "v" },
      },
      {
        "g<C-x>",
        function()
          return require("dial.map").manipulate("decrement", "normal")
        end,
        desc = "Decrement",
        mode = { "n", "v" },
      },
    },
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.date.new {
            pattern = "%B", -- titlecased month names
            default_kind = "day",
          },
          augend.constant.new {
            elements = {
              "january",
              "february",
              "march",
              "april",
              "may",
              "june",
              "july",
              "august",
              "september",
              "october",
              "november",
              "december",
            },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = {
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday",
              "Sunday",
            },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = {
              "monday",
              "tuesday",
              "wednesday",
              "thursday",
              "friday",
              "saturday",
              "sunday",
            },
            word = true,
            cyclic = true,
          },
          augend.case.new {
            types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" },
          },
        },
      }
    end,
  },
}
