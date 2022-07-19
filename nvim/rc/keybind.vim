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

nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> + <C-a>
nnoremap <silent> - <C-x>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> * "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nnoremap <silent> gp "+p

nnoremap <Leader>c/ :%s //&/gn<CR>
nnoremap <Leader>/  :%s /
nnoremap <Leader>[ 0v$<Left>
nnoremap <Leader>] ^v$<Left>

nnoremap <C-j> 4j
nnoremap <C-k> 4k

" cheat sheet
nnoremap <silent> <Leader>ch :Cheat<CR>

" manipulate tab
nmap [Tab] <Nop>
nmap <Leader>t [Tab]
nnoremap [Tab]n :$tabnew<CR>
nnoremap [Tab]l :tabnext<CR>
nnoremap [Tab]h :tabprevious<CR>
nnoremap [Tab]x :tabclose<CR>
nnoremap [Tab]o :tabonly<CR>
for n in range (1, 9)
    execute 'nnoremap <silent> [Tab]'.n ':<C-u>tabnext'.n.'<CR>'
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
nnoremap <silent> [Mark]m :<C-u>call <SID>AutoMarkrement()<CR>
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

" vimfiler setting
" nnoremap <Leader>vf :VimFiler -split -no-quit -winwidth=45 -simple

" Open Defx
nnoremap <silent> <leader>e :Defx -resume<CR>
nnoremap <silent> <leader>E :Defx -split=vertical -winwidth=50 -direction=topleft -toggle -resume<CR>
nnoremap <silent> <leader>w :Defx `expand('%:p:h')` -search=expand('%:p')`<CR>
nnoremap <silent> <leader>W :Defx -split=vertical -winwidth=50 -direction=topleft -toggle `expand('%:p:h')` -search=expand('%:p')`<CR>

" denite setting
nmap [Denite] <Nop>
nmap <Leader>d [Denite]
nnoremap <silent> [Denite]b :Denite buffer -buffer-name=buf<CR>
nnoremap <silent> [Denite]r :Denite -resume<CR>
nnoremap <silent> [Denite]gr :Denite -resume -buffer-name=dgrep<CR>
nnoremap <silent> [Denite]d :Denite directory_rec<CR>
nnoremap <silent> [Denite]f :Denite file<CR>
nnoremap <silent> [Denite]D :Denite file/rec<CR>
nnoremap <silent> [Denite]F :DeniteBufferDir file<CR>
nnoremap <silent> [Denite]pf :DeniteProjectDir file<CR>
nnoremap <silent> [Denite]pd :DeniteProjectDir directory_rec<CR>
nnoremap <silent> [Denite]; :DeniteCursorWord line<CR>
nnoremap <silent> [Denite]l :Denite line<CR>
nnoremap <silent> [Denite]m :Denite menu<CR>
nnoremap <silent> [Denite]c :Denite menu:commands<CR>
nnoremap <silent> [Denite]o :Denite outline<CR>
nnoremap <silent> [Denite]O :DeniteCursorWord outline<CR>
nnoremap <silent> [Denite]] :DeniteCursorWord gtags_context<CR>
nnoremap <silent> [Denite]y :Denite neoyank register<CR>
nnoremap <silent> [Denite]h :Denite file/old<CR>
nnoremap <silent> [Denite]e :Denite defx/history<CR>
nnoremap <silent> [Denite]a :Denite change<CR>
nnoremap <silent> [Denite]M :Denite mark<CR>

xmap [Denite] <Nop>
xmap <Leader>d [Denite]
xnoremap <silent> [Denite]y :Denite neoyank register -default-action=replace<CR>

" if dein#tap('vim-quickrun')
    " nnoremap <leader>r :QuickRun<CR>
" endif
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

if has('nvim')
    " open terminal
    if executable('fish')
        nnoremap <silent> <Leader>lb :botright split<CR>:terminal fish<CR>i
        nnoremap <silent> <Leader>lt :$tabnew<CR>:terminal fish<CR>i
    else
        nnoremap <silent> <Leader>lb :botright split<CR>:terminal<CR>i
        nnoremap <silent> <Leader>lt :$tabnew<CR>:terminal<CR>i
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
endif
