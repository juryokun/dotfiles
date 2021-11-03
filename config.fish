# fish setting
# umask 022

# fisher
set fish_theme bobthefish
set theme_color_scheme zenburn
set -g theme_date_timezone Asia/Tokyo
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
set PATH ~/cmd $PATH
set PATH ~/development/flutter/bin $PATH

# for haskell
set PATH ~/.local $PATH

# x-server
# export DISPLAY=localhost:0.0

# rust
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin

# pyenv
set -Ux PYENV_ROOT ~/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
if command -v pyenv 1>/dev/null 2>&1
    if status is-login && test -z "$TMUX"
        pyenv init --path fish | source
    end
    pyenv init - fish | source
#    pyenv virtualenv-init - fish | source
end

if test -e ~/cmd/start_tmux.sh
    bash ~/cmd/start_tmux.sh
end
