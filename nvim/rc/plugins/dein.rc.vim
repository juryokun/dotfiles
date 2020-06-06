" dein path
let s:dein_dir = fnamemodify(expand('<sfile>'), ':h') . '/../dein/'
let s:dein_repo_dir = s:dein_dir . 'repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" add runtimepath
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" load settings
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " toml files
    let g:toml_dir       = s:dein_dir . '../tomls/'
    let s:toml      = g:toml_dir . 'dein.toml'
    let s:lazy_toml = g:toml_dir . 'dein_lazy.toml'

    " load toml files
    call dein#load_toml(s:toml,      {'lazy' : 0})
    call dein#load_toml(s:lazy_toml, {'lazy' : 1})

    " finish loading
    call dein#end()
    call dein#save_state()
endif
filetype plugin indent on
syntax enable

" install plugins
if dein#check_install()
    call dein#install()
endif

