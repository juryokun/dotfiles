let s:rc_dir = fnamemodify(expand('<sfile>'), ':h') . '/..'
let s:jetpackpath = s:rc_dir . '/packages'
execute 'set packpath=' . s:jetpackpath

let s:jetpackfile = s:jetpackpath . '/pack/jetpack-src/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack

let s:plugin_rc_dir = s:rc_dir . '/plugin_rc'
call jetpack#begin(s:jetpackpath)
if exists('g:vscode')
  execute 'source' s:plugin_rc_dir . '/jetpack_vscode.rc.vim'
elseif has('win32')
  execute 'source' s:plugin_rc_dir . '/jetpack_win.rc.vim'
else
  execute 'source' s:plugin_rc_dir . '/jetpack_default.rc.vim'
endif
call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor
