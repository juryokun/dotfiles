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

if jetpack#tap('lightline.vim')
    execute 'source' s:plugin_rc_dir . '/lightline.rc.vim'
endif