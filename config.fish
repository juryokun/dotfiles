# fish setting
# umask 022
if status is-interactive
    # Commands to run in interactive sessions can go here
    # ・
    # ・（他にコマンドがあればここに記述されているはず）
    # ・
    if test "$(uname)"='Darwin'
        eval (/opt/homebrew/bin/brew shellenv) # <= これを追加
    end
end

export GPG_TTY=$(TTY)

# fisher
set fish_theme bobthefish
set theme_color_scheme zenburn
set -g theme_date_timezone Asia/Tokyo

# nvim
which nvim >/dev/null 2>&1
if test $status -eq 0
    alias lv 'nvim -R'
end

alias upall 'brew update && brew upgrade && fisher update && cargo install-update -a'
alias vf 'vifm'
# docker setting
# export DOCKER_HOST='tcp://0.0.0.0:2375'

# path
set PATH ~/cmd $PATH
set PATH ~/development/flutter/bin $PATH

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

# volta(node manager)
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

if test -e ~/cmd/start_tmux.sh
    bash ~/cmd/start_tmux.sh
end

# zoxide
zoxide init fish | source
set -x _ZO_DATA_DIR ~/.local/share/zoxide
export _ZO_FZF_OPTS='--reverse --height 60% --preview "echo {} |awk \'{print $2}\' | xargs ls"'

# skim
which sk >/dev/null 2>&1
if test $status -eq 0
    alias skf 'rg --files | sk --preview="cat {}"'
    alias skc 'sk --ansi -i -c \'rg --color=always --line-number "{}"\''

    set -l isExists (type -t skim_key_bindings)
    if [ $isExists="function" ]
        skim_key_bindings
    end
end

# lf
set -gx EDITOR "nvim"

function zipwin
  argparse -n zipwin 'p/password' -- $argv
  or return 1
  
  set -g zipcmd '7z a -tzip -scsWIN'
  if set -lq _flag_password
    set -g zipcmd "$zipcmd -p"
  end

  if test \( -z "$argv[1]" -o "$argv[1]" = . \)
    # 現在の作業ディレクトリをZIPファイルに圧縮する．
    set -g zip_name "$(basename $(pwd)).zip"
    set -g excommand "fd --type file --strip-cwd-prefix . -X $zipcmd $zip_name {}"
  else
    # 指定したディレクトリをZIPファイルに圧縮する．
    set -l local_dir (dirname $argv[1])
    set -l target (basename $argv[1])
    set -g zip_name "$(pwd)/$target.zip"
    set -g excommand "fd --type file --base-directory=$local_dir . $target -X $zipcmd $zip_name {}"
  end
  eval $excommand

  # 作成したZIPファイルに含まれるファイルを確認する．不要であればコメントアウトしてください．
  7z l $zip_name

  return 0
end
