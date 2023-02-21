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
" let g:python3_host_prog = expand('~/pyvenv/dev/bin/python')


if $SHELL =~ '/fish$'
    set shell=bash
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

" https://orange-factory.com/dnf/utf-8.html
call setcellwidths([
    \   [ 0x25a0, 0x25ff, 2 ],
    \   [ 0x203b, 0x203b, 2 ],
    \   [ 0x2460, 0x24ff, 2 ],
    \   [ 0x2190, 0x21af, 2 ],
    \   [ 0x21c0, 0x21ff, 2 ],
    \])
