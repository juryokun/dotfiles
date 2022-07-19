let s:jetpackpath = fnamemodify(expand('<sfile>'), ':h') . '/../packages'
execute 'set packpath=' . s:jetpackpath

let s:jetpackfile = s:jetpackpath . '/pack/jetpack-src/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack

call jetpack#begin(s:jetpackpath)
Jetpack 'machakann/vim-sandwich'
Jetpack 'vim-denops/denops.vim'
Jetpack 'Shougo/ddu.vim'
Jetpack 'Shougo/ddu-ui-ff'
Jetpack 'Shougo/ddu-source-file'
Jetpack 'Shougo/ddu-source-register'
Jetpack 'kuuote/ddu-source-mr'
Jetpack 'lambdalisue/mr.vim'
Jetpack 'shun/ddu-source-buffer'
Jetpack 'Shougo/ddu-filter-matcher_substring'
Jetpack 'Shougo/ddu-commands.vim'
Jetpack 'Shougo/ddu-kind-file'
Jetpack 'shun/ddu-source-rg'
call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor


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
nnoremap <SID>[ug] <Nop>
nmap ,u <SID>[ug]

nnoremap <silent> <SID>[ug]m :<C-u>Ddu mr<CR>
nnoremap <silent> <SID>[ug]b :<C-u>Ddu buffer<CR>
nnoremap <silent> <SID>[ug]r :<C-u>Ddu register<CR>
nnoremap <silent> <SID>[ug]n :<C-u>Ddu file -source-param-new -volatile<CR>
nnoremap <silent> <SID>[ug]f :<C-u>Ddu file<CR>