"set leader
let mapleader = "\<Space>"

nmap <leader>e <cmd>call VSCodeNotify('workbench.view.explorer')<cr>
nmap <leader>q <cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>
nmap <leader>b <cmd>call VSCodeNotify('workbench.action.showAllEditors')<cr>
nmap <leader>h <cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>
nmap <leader>l <cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>
nmap <leader>] <cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>
nmap <leader><C-]> <cmd>call VSCodeNotify('workbench.action.showAllSymbols')<cr>

