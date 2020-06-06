"==============================================================================================
" FUNCTIONS
"==============================================================================================
function! SetUU()
    set ff=unix
    set fenc=utf8
endfunction
command! -nargs=0 SetUU call SetUU()

function! SwitchPasteMode()
    if &paste
        set nopaste
    else
        set paste
    endif
endfunction
command! -nargs=0 SwitchPasteMode call SwitchPasteMode()

function! SwitchTabWidth()
    if &tabstop == 4
        set tabstop=2
    else
        set tabstop=4
    endif
    if &shiftwidth == 4
        set shiftwidth=2
    else
        set shiftwidth=4
    endif
endfunction
command! -nargs=0 SwitchTabWidth call SwitchTabWidth()
