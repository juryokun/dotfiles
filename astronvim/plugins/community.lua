return {
  "AstroNvim/astrocommunity",
  -- ここにAstroNvim Communityからimportしたい設定を追記していく
  { import = "astrocommunity.motion.hop-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { "nvim-surround",
    opts = {
      keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "<leader>s",
          visual_line = "<leader>gs",
          delete = "ds",
          change = "cs",
      },
    }
  },
  { import = "astrocommunity.git.neogit" },
  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { -- further customize the options set by the community
  --   "catppuccin",
  --   opts = {
  --     integrations = {
  --       sandwich = false,
  --       noice = true,
  --       mini = true,
  --       leap = true,
  --       markdown = true,
  --       neotest = true,
  --       cmp = true,
  --       overseer = true,
  --       lsp_trouble = true,
  --       ts_rainbow2 = true,
  --     },
  --   },
  -- },
}
