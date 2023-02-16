"==============================================================================================
" SETTING
"==============================================================================================
set noswapfile
set nobackup
set noundofile
set ruler
set relativenumber
set hidden
set laststatus=2
set showmode
set showcmd
set cursorline

" set manipulation by cursor
set whichwrap=b,s,h,l,,[,]

" set the max number of candidate
set pumheight=10

" no beep
set belloff=all
set noerrorbells

" search setting
set ignorecase
set smartcase
" replace setting
set inccommand=split

" file encording
if has('win32')
    scriptencoding utf-8
    set encoding=utf-8
endif
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,sjis,utf-8
set fileformats=unix,dos,mac

" indent setting
set tabstop=4
set expandtab
set shiftwidth=4
set modifiable
set write
set backspace=indent,eol,start
set list
set termguicolors

set listchars=tab:»-,trail:_,nbsp:%
if has('nvim')
    set listchars=tab:»-,trail:_,nbsp:%,eol:↲
endif

" ctag setting
"set tags=./tags;,./TAGS;,tags;,TAGS;

" set python path
let g:python3_host_prog = expand('~/pyvenv/dev/bin/python')
" let g:python_host_prog = expand('~/pyvenv/neo2/bin/python')
" if executable('/usr/bin/python3')
"     let g:python3_host_prog = expand('/usr/bin/python3')
" elseif executable(g:tools_path.'/python3/python')
"     let g:python3_host_prog = expand(g:tools_path.'/python3/python')
" endif


if $SHELL =~ '/fish$'
    set shell=bash
endif
if has('win32')
    set shell=powershell
endif

" tab setting
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()  "{{{
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = (fnamemodify(bufname(bufnr), ':t') != '' ? fnamemodify(bufname(bufnr), ':t') : 'No Nmame')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'


" neovim setting
" if has('nvim')
"     " share clipbord
"     set clipboard+=unnamedplus
"     if system('uname -a | grep Microsoft') != ""
"         let g:clipboard = {
"             \   'name': 'myClipboard',
"             \   'copy': {
"             \      '+': 'win32yank.exe -i',
"             \      '*': 'win32yank.exe -i',
"             \    },
"             \   'paste': {
"             \      '+': 'win32yank.exe -o',
"             \      '*': 'win32yank.exe -o',
"             \   },
"             \   'cache_enabled': 1,
"             \ }
"     endif
" elseif has('windows')
"     set clipboard+=unnamed
" endif

" function! s:isWsl()
"     return filereadable('/proc/sys/fs/binfmt_misc/WSLInterop')
" endfunction
" if s:isWsl() && executable('AutoHotkeyU64.exe')
"     augroup insertLeave
"         autocmd!
"         autocmd InsertLeave * :call system('AutoHotkeyU64.exe "'.g:tools_path.'\ImeDisable.ahk"')
"     augroup END
" endif
"
call setcellwidths([[ 0x25A0, 0x25ff, 2 ]])
