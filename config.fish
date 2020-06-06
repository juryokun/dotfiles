# fish setting
# umask 022

# fisher
set fish_theme bobthefish
set theme_color_scheme zenburn
set -x FZF_LEGACY_KEYBINDINGS 1

# alias
which nvim >/dev/null 2>&1
if test $status -eq 0
    alias lv 'nvim -R'
end

# fzf
export FZF_DEFAULT_OPTS='--reverse'

# vagrant setting
# export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS=1
# export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

# docker setting
# export DOCKER_HOST='tcp://0.0.0.0:2375'

# path
set PATH ~/bin $PATH
set PATH ~/development/flutter/bin $PATH

# x-server
# export DISPLAY=localhost:0.0

# pyenv
set PATH ~/.pyenv/bin $PATH
if which pyenv > /dev/null; eval (pyenv init - | source); end

