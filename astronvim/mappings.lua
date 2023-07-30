-- hop.nvim
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 's', function()
  hop.hint_anywhere()
end, {remap=true})
vim.keymap.set('', ',f', function()
  hop.hint_char1()
end, {remap=true})
vim.keymap.set('', ',g', function()
  hop.hint_char2()
end, {remap=true})
vim.keymap.set('', ',.', function()
  hop.hint_patterns()
end, {remap=true})
vim.keymap.set('', ',/', function()
  hop.hint_patterns({}, vim.api.nvim_exec('echo @/', true))
end, {remap=true})


return {
  n = {
    ["<leader>,"] = {"<cmd>source $MYVIMRC<CR>", desc = "Reload Config"},
  },
}
