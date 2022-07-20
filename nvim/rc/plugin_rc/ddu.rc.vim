"ddu-setting
call ddu#custom#patch_global({
    \   'ui': 'ff',
    \   'sources': [{'name':'file','params':{}},{'name':'mr'},{'name':'register'},{'name':'buffer'}],
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'kindOptions': {
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \     'word': {
    \       'defaultAction': 'append',
    \     },
    \   },
    \   'sourceParams' : {
    \     'rg' : {
    \       'args': ['--column', '--no-heading', '--color', 'never'],
    \     },
    \   },
    \ })

"ddu-key-setting
autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  nnoremap <buffer> <CR>
  \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> q
  \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  inoremap <buffer> <CR>
  \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  inoremap <buffer> <C-j>
  \ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)")<CR>
  inoremap <buffer> <C-k>
  \ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)")<CR>
endfunction

"ddu keymapping.
let mapleader = "\<Space>"

nnoremap [Ddu] <Nop>
nmap <Leader>d [Ddu]

nnoremap <silent> [Ddu]m :<C-u>Ddu mr<CR>
nnoremap <silent> [Ddu]b :<C-u>Ddu buffer<CR>
nnoremap <silent> [Ddu]r :<C-u>Ddu register<CR>
nnoremap <silent> [Ddu]n :<C-u>Ddu file -source-param-new -volatile<CR>
nnoremap <silent> [Ddu]f :<C-u>Ddu file<CR>