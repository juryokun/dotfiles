-- hop.nvim
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', '<leader>j/', function()
  hop.hint_patterns()
end, {remap=true})
vim.keymap.set('', '<leader>j*', function()
  hop.hint_patterns({}, vim.api.nvim_exec('echo @/', true))
end, {remap=true})

return {
  n = {
    ["<leader>,"] = {"<cmd>source $MYVIMRC<CR>", desc = "Reload Config"},
  },
}
