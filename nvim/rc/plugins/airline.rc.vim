"==============================================================================================
" AIRLINE SETTINGS
"==============================================================================================
set showtabline=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'jellybeans'
let g:airline#extensions#whitespace#mixed_indent_algo = 1
" let g:airline#extensions#whitespace#enabled = 1
" let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#readonly#enabled = 1

let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'z', 'error', 'warning']
    \ ]

let g:airline_section_b =
    \ '%{airline#extensions#branch#get_head()}' .
    \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
    \ '%t%( %M%)'
let g:airline_section_c = ''
let s:sep = " %{get(g:, 'airline_right_alt_sep', '')} "
let g:airline_section_x =
    \ "%{strlen(&fileformat)?&fileformat:''}".s:sep.
    \ "%{strlen(&fenc)?&fenc:&enc}".s:sep.
    \ "%{strlen(&filetype)?&filetype:'no ft'}"
