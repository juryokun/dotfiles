"==============================================================================================
" DENITE SETTING
"==============================================================================================
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ADD CUSTOM MENUS

let s:menus = {}
let s:menus.commands = {
    \ 'description': 'useful commands' }
let s:menus.gtags = {
    \ 'description': 'gtags command' }

let s:menus.gtags.command_candidates = [
    \ ['Definition of tag', 'DeniteCursorWord gtags_def'],
    \ ['References to tag', 'DeniteCursorWord gtags_ref'],
    \ ['grep search of tag', 'DeniteCursorWord gtags_grep'],
    \ ['Definition/References to tag', 'DeniteCursorWord gtags_context'],
    \ ['List all tags', 'Denite gtags_completion']]
let s:menus.commands.command_candidates = [
    \ ['Reload init.vim', 'source '.g:cf_path.'/init.vim'],
    \ ['Update Plugins', 'call dein#update()'],
    \ ['Find setting files of Nvim', 'Denite file/rec/nvim:'.g:cf_path],
    \ ['Fileencording change to utf8', 'SetUU'],
    \ ['Change CRLF to LF', '%s /\r\n/\r/g'],
    \ ['Change filetype', 'Denite filetype'],
    \ ['Switch Paste or NoPaste mode', 'SwitchPasteMode'],
    \ ['Switch TabWidth 4 or 2', 'SwitchTabWidth'],
    \ ['Grep Standard', 'Denite grep -buffer-name=dgrep -no-empty'],
    \ ['Grep Standard below ProjectDir', 'DeniteProjectDir grep -buffer-name=dgrep -no-empty'],
    \ ['Grep Standard below BufferDir', 'DeniteBufferDir grep -buffer-name=dgrep -no-empty'],
    \ ['Grep CursorWord', 'DeniteCursorWord grep -buffer-name=dgrep -no-empty'],
    \ ['Grep CursorWord below ProjectDir', 'DeniteProjectDir grep:::`expand("<cword>")` -buffer-name=dgrep -no-empty'],
    \ ['Grep CursorWord below BufferDir', 'DeniteBufferDir grep:::`expand("<cword>")` -buffer-name=dgrep -no-empty']]

call denite#custom#var('menu', 'menus', s:menus)

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" CUSTOM COMMAND

if executable('rg')
    call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('directory_rec', 'command', ['find', '-L', ':directory', 
        \ '-path', '*/.svn/*', '-prune', '-o',
        \ '-path', '*/.git/*', '-prune', '-o',
        \ '-path', '*/.cache/*', '-prune', '-o',
        \ '-path', '*/__pycache__/*', '-prune', '-o',
        \ '-type', 'd', '-print',
        \ ])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    call denite#custom#alias('source', 'file/rec/nvim', 'file/rec')
    call denite#custom#var('file/rec/nvim', 'command', ['rg', '--files', '--glob', '!.git'])
endif


" Change mathcers
call denite#custom#source('file/rec', 'matchers', ['matcher_fuzzy'])
call denite#custom#source('file/old', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
" call denite#custom#source('directory_rec', 'matchers', ['matcher_cpsm'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/fuzzy','matcher/ignore_globs'])
 call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/', '.cache/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
    \   '*.o', '*.exe', '*.bak', '.DO_Store', '*.pyc',
    \   '*sw[po]', '*.class', '.hg', '.bzr', '.svn/',
    \   'tags', 'tags-*', '*~'
    \ ])

call denite#custom#source('file/old', 'converters', ['converter/relative_word'])
call denite#custom#source('file/rec', 'converters', ['converter/relative_word'])

call denite#custom#option('default', {
    \ 'auto_accel': v:true,
    \ 'prompt': '>',
    \ 'source_names': 'short',
    \ })
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ADD KEY MAPPINGS
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q       denite#do_map('quit')
    nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
    nnoremap <silent><buffer><expr> <C-l>   denite#do_map('redraw')
    nnoremap <silent><buffer><expr> m       denite#do_map('quick_move')
    nnoremap <silent><buffer><expr> u       denite#do_map('move_up_path')
    nnoremap <silent><buffer><expr> l       denite#do_map('choose_action')
    nnoremap <silent><buffer><expr> M       denite#do_map('toggle_matchers', 'matcher_substring')
endfunction
