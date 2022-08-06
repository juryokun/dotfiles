"==============================================================================================
"PLUGIN SETTINGS
"==============================================================================================
let s:plugin_rc_dir = fnamemodify(expand('<sfile>'), ':h') . '/plugin_rc'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Load Dein
execute 'source' s:plugin_rc_dir . '/jetpack.rc.vim'


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Load Plugin Settings

if jetpack#tap('ddu.vim')
    execute 'source' s:plugin_rc_dir . '/ddu.rc.vim'
endif

if jetpack#tap('vim-sandwich')
    execute 'source' s:plugin_rc_dir . '/vim-sandwich.rc.vim'
endif

if jetpack#tap('lightline.vim')
    execute 'source' s:plugin_rc_dir . '/lightline.rc.vim'
endif

if jetpack#tap('indent-blankline.nvim')
    execute 'source' s:plugin_rc_dir . '/indent-blankline.rc.vim'
endif

if jetpack#tap('mason.nvim')
    execute 'source' s:plugin_rc_dir . '/mason.rc.vim'
endif

if jetpack#tap('ddc.vim')
    execute 'source' s:plugin_rc_dir . '/ddc.rc.vim'
endif

if jetpack#tap('fuzzy-motion.vim')
    execute 'source' s:plugin_rc_dir . '/fuzzy-motion.rc.vim'
endif

