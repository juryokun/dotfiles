"=============================================================================================
" KEY BIND SETTINGS
"=============================================================================================
" USING LEADER

"set leader
let mapleader = "\<Space>"

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" INSERT MODE

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Del>
" inoremap jj <Esc>
" inoremap ｊｊ <Esc>
" move to beginning of line
inoremap <silent> <C-a> <Esc>^<Insert>
" move to end of line
inoremap <silent> <C-e> <Esc>$<Insert><Right>

" manipulate window
inoremap <A-h> <ESC><C-w>h
inoremap <A-j> <ESC><C-w>j
inoremap <A-k> <ESC><C-w>k
inoremap <A-l> <ESC><C-w>l
inoremap <A-o> <ESC><C-w>w

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" NORMAL MODE

nnoremap <silent> ]b <Cmd>bnext<CR>
nnoremap <silent> [b <Cmd>bprevious<CR>
nnoremap <silent> + <C-a>
nnoremap <silent> - <C-x>
nnoremap <silent> <Esc><Esc> <Cmd>nohlsearch<CR>
nnoremap <silent> * "zyiw:let @/ = '\<' . @z . '\>'<CR><Cmd>set hlsearch<CR>
nnoremap <silent> gp "+p

nnoremap <Leader>c/ :%s //&/gn<CR>
nnoremap <Leader>/  :%s /
nnoremap <Leader>[ 0v$<Left>
nnoremap <Leader>] ^v$<Left>

nnoremap <C-j> 4j
nnoremap <C-k> 4k

nnoremap <Leader>; <Cmd>source $MYVIMRC<CR>

" manipulate tab
nmap [Tab] <Nop>
nmap <Leader>t [Tab]
nnoremap [Tab]n <Cmd>$tabnew<CR>
nnoremap [Tab]l <Cmd>tabnext<CR>
nnoremap [Tab]h <Cmd>tabprevious<CR>
nnoremap [Tab]x <Cmd>tabclose<CR>
nnoremap [Tab]o <Cmd>tabonly<CR>
for n in range (1, 9)
    execute 'nnoremap <silent> [Tab]'.n '<Cmd>tabnext'.n.'<CR>'
endfor

" manipulate window
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-o> <C-w>w

" mark setting
nnoremap [Mark] <Nop>
nmap m [Mark]
nnoremap [Mark]n ]`
nnoremap [Mark]p [`
nnoremap <silent> [Mark]m <Cmd>call <SID>AutoMarkrement()<CR>
if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction

"nmap [Ddu] <Nop>
"nmap <Leader>d [Ddu]
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" COMMAND MODE

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" VISUAL MODE

xnoremap <silent> gy "+y
xnoremap <silent> gp "+p
xnoremap <silent> * mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z
xnoremap ] :<C-u>call <SID>set_vsearch()<CR>/<C-r>/<CR>
"xmap # <Space>:%s/<C-r>///g<Left><Left>

function! s:set_vsearch()
    silent normal gv"zy
    let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" TERMINAL SETTINGS

" open terminal
if executable('fish')
    nnoremap <silent> <Leader>lb <Cmd>botright split<CR><Cmd>terminal fish<CR>i
    nnoremap <silent> <Leader>lt <Cmd>$tabnew<CR><Cmd>terminal fish<CR>i
else
    nnoremap <silent> <Leader>lb <Cmd>botright split<CR><Cmd>terminal<CR>i
    nnoremap <silent> <Leader>lt <Cmd>$tabnew<CR><Cmd>terminal<CR>i
endif

" TERMINAL MODE
tnoremap <C-\><C-\> <C-\><C-n>
tnoremap <C-q> <C-\><C-n>:q<CR>

" manipulate window
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-o> <C-\><C-n><C-w>w

