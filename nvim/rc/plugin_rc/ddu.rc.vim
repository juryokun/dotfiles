"ddu-setting
call ddu#custom#patch_global({
    \   'ui': 'ff',
    \   'sources': [{'name':'file','params':{}},{'name':'mr'},{'name':'register'},{'name':'buffer'}],
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \       'ignoreCase': v:true,
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
    \   'uiParams': {
    \     'ff': {
    \       'prompt': '>',
    \     },
    \   },
    \   'filterParams': {
    \      'matcher_substring': {
    \          'highlightMatched': 'Search',
    \      },
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
    \       'sort': 'filename',
    \     },
    \   },
    \   'refresh' : v:true,
    \   'resume' : v:true,
    \   'sources': s:fx_conf_sources,
    \   'sourceOptions': s:fx_conf_sourceOptions,
    \   'kindOptions': s:fx_conf_kindOptions,
    \ })

call ddu#custom#patch_local('grep', {
    \   'sourceParams' : {
    \     'rg' : {
    \       'args': ['--column', '--no-heading', '--color', 'never'],
    \     },
    \   },
    \   'uiParams': {
    \     'ff': {
    \       'startFilter': v:false,
    \     }
    \   },
    \ })

"ddu-key-setting
autocmd FileType ddu-ff call s:ddu_ff_my_settings()
function! s:ddu_ff_my_settings() abort
    nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
    nnoremap <buffer><silent> <Space><Space>
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
    nnoremap <buffer><silent> <Space><Space>
        \ <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
    nnoremap <buffer> o
        \ <Cmd>call ddu#ui#filer#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
    nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>
    nnoremap <buffer><silent> ..
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>
    nnoremap <buffer><silent> c
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'copy'})<CR>
    nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'paste'})<CR>
    nnoremap <buffer><silent> dd
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'delete'})<CR>
    nnoremap <buffer><silent> r
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'rename'})<CR>
    nnoremap <buffer><silent> mv
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'move'})<CR>
    nnoremap <buffer><silent> tf
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newFile'})<CR>
    nnoremap <buffer><silent> td
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newDirectory'})<CR>
    nnoremap <buffer><silent> yy
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'yank'})<CR>
endfunction

command! DduRgLive call <SID>ddu_rg_live()
function! s:ddu_rg_live() abort
    call ddu#start({
        \   'name': 'grep',
        \   'volatile': v:true,
        \   'sources': [{
        \     'name': 'rg',
        \     'options': {'matchers': []},
        \   }],
        \   'uiParams': {'ff': {
        \     'ignoreEmpty': v:false,
        \     'autoResize': v:false,
        \   }},
        \   'resume' : v:false
        \ })
endfunction


command! DduCustomGrep call <SID>ddu_custom_grep()
function! s:ddu_custom_grep() abort
    let grep_text = input("search-word : ")
    if grep_text == ""
        let grep_text = expand('<cword>')
    endif
    let search_path = input("search-path : ")
    call ddu#start({
        \   'name': 'grep',
        \   'sources':[
        \     {'name': 'rg', 'params': {'input': grep_text, 'path': search_path}}
        \   ],
        \   'resume': v:false,
        \})
endfunction

"ddu keymapping.
let mapleader = "\<Space>"

nnoremap [Ddu] <Nop>
nmap <Leader>d [Ddu]

nnoremap <silent> [Ddu]h <Cmd>Ddu mr<CR>
nnoremap <silent> [Ddu]b <Cmd>Ddu buffer<CR>
nnoremap <silent> [Ddu]r <Cmd>Ddu register<CR>
nnoremap [Ddu]g <Cmd>DduCustomGrep<CR>
nnoremap <silent> [Ddu]G <Cmd>DduRgLive<CR>
nnoremap <silent> [Ddu]. <Cmd>call ddu#start({
    \   'name': 'grep',
    \   'resume': v:true,
    \})<CR>
nnoremap <silent> [Ddu]F <Cmd>call ddu#start({
    \   'name': 'grep',
    \   'sources':[
    \     {'name': 'file_rec'}
    \   ],
    \   'resume': v:false,
    \})<CR>

nnoremap <silent> <Leader>e <Cmd>call ddu#start({
    \   'name': 'fx',
    \   'searchPath': "",
    \   'uiParams': {
    \     'filer': {
    \       'split': 'no',
    \     },
    \   },
    \   'resume' : v:true,
    \})<CR>
nnoremap <silent> <Leader>E <Cmd>call ddu#start({
    \   'name': 'fx',
    \   'searchPath': "",
    \   'uiParams': {
    \     'filer': {
    \       'split': 'vertical',
    \       'splitDirection': 'topleft',
    \       'winWidth': &columns / 3,
    \     },
    \   },
    \   'resume' : v:true,
    \})<CR>
nnoremap <silent> <Leader>r <Cmd>call ddu#start({
    \   'name': 'fx',
    \   'searchPath': expand("%:p"),
    \   'resume' : v:false
    \ })<CR>
