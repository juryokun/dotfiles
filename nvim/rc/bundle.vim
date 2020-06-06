"==============================================================================================
"PLUGIN SETTINGS
"==============================================================================================
let s:plugins_dir = fnamemodify(expand('<sfile>'), ':h') . '/plugins'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Load Dein
execute 'source' s:plugins_dir . '/dein.rc.vim'


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Load Plugin Settings

" Denite Settings
if dein#tap('denite.nvim')
    execute 'source' s:plugins_dir . '/denite.rc.vim'
endif

" status line
if dein#tap('lightline.vim')
    if has('nvim')
        execute 'source' s:plugins_dir . '/lightline.rc.vim'
    else
        execute 'source' s:plugins_dir . '/lightline_default.rc.vim'
    endif
endif

" Airline Settings
if dein#tap('vim-airline')
    execute 'source' s:plugins_dir . '/airline.rc.vim'
endif
