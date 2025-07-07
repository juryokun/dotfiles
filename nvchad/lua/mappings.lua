require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })

local treeutils = require "custom.plugins.nvim-tree.treeutils"
map("n", "<Leader>fd", function()
  treeutils.launch_find_files()
end, { desc = "Telescope Find in under cursol directory" })
map("n", "<Leader>fl", function()
  treeutils.launch_live_grep()
end, { desc = "Telescope live grep in under cursol directory" })
