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

let s:fx_conf_sources = [{'name': 'file', 'params': {}}]
let s:fx_conf_sourceOptions = {'_': {'columns': ['icon_filename']}}
let s:fx_conf_kindOptions = {'file': {'defaultAction': 'open'}}
call ddu#custom#patch_local('fx', {
    \   'ui': 'filer',
    \   'uiParams': {
    \     'filer': {
    \       'split': 'no',
    \       'sortTreesFirst': v:true,
    \     },
    \   },
    \   'sources': s:fx_conf_sources,
    \   'sourceOptions': s:fx_conf_sourceOptions,
    \   'kindOptions': s:fx_conf_kindOptions,
    \ })

call ddu#custom#patch_local('fx-left', {
    \   'ui': 'filer',
    \   'uiParams': {
    \     'filer': {
    \       'split': 'vertical',
    \       'sortTreesFirst': v:true,
    \       'splitDirection': 'topleft',
    \       'winWidth': &columns / 3,
    \     },
    \   },
    \   'sources': s:fx_conf_sources,
    \   'sourceOptions': s:fx_conf_sourceOptions,
    \   'kindOptions': s:fx_conf_kindOptions,
    \ })

"ddu-key-setting
autocmd FileType ddu-ff call s:ddu_ff_my_settings()
function! s:ddu_ff_my_settings() abort
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
    inoremap <buffer> <CR>
        \ <Esc><Cmd>call ddu#ui#ff#close()<CR>
    nnoremap <buffer> <CR>
        \ <Cmd><Cmd>call ddu#ui#ff#close()<CR>
endfunction


autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#filer#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> o
        \ <Cmd>call ddu#ui#filer#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>
endfunction


"ddu keymapping.
let mapleader = "\<Space>"

nnoremap [Ddu] <Nop>
nmap <Leader>d [Ddu]

nnoremap <silent> [Ddu]h :<C-u>Ddu mr<CR>
nnoremap <silent> [Ddu]b :<C-u>Ddu buffer<CR>
nnoremap <silent> [Ddu]r :<C-u>Ddu register<CR>
nnoremap <silent> [Ddu]n :<C-u>Ddu file -source-param-new -volatile<CR>
nnoremap <silent> [Ddu]f :<C-u>Ddu file<CR>
nnoremap <silent> [Ddu]F :<C-u>Ddu file_rec<CR>
nnoremap <silent> <Leader>E :<C-u>Ddu -name=fx-left<CR>
nnoremap <silent> <Leader>e :<C-u>Ddu -name=fx<CR>
