# fish setting
# umask 022

# fisher
set fish_theme bobthefish
set theme_color_scheme zenburn
set -g theme_date_timezone Asia/Tokyo
set -U FZF_LEGACY_KEYBINDINGS 0

# alias
which nvim >/dev/null 2>&1
if test $status -eq 0
    alias lv 'nvim -R'
end

# fzf
export FZF_DEFAULT_OPTS='--reverse'
# function __fzf_z -d 'Find and Jump to a recent directory.'
#   set -l query (commandline)
#
#   if test -n $query
#     set flags --query "$query"
#   end
#
#   z -l | awk '{ print $2 }' | eval (__fzfcmd) "$FZF_DEFAULT_OPTS $flags" | read recent
#   if [ $recent ]
#       cd $recent
#       commandline -r ''
#       commandline -f repaint
#   end
# end
# bind \cz __fzf_z
# #bind \cx __fzf_cd
# bind ç __fzf_cd

function __fzf_open_code -d 'Open file with Code.'
  code -r $(fzf)
end
bind \eO __fzf_open_code
bind Ø __fzf_open_code

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
    status is-login; and pyenv init --path | source
    status is-interactive; and pyenv init - | source
#    if status is-login && test -z "$TMUX"
#        pyenv init --path fish | source
#    end
#    pyenv init - fish | source
#    pyenv virtualenv-init - fish | source
end

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

if test -e ~/cmd/start_tmux.sh
    bash ~/cmd/start_tmux.sh
end

# zoxide
zoxide init fish | source
set -x _ZO_DATA_DIR ~/.local/share/zoxide
export _ZO_FZF_OPTS='--reverse --height 60% --preview "echo {} |awk \'{print $2}\' | xargs ls"'
