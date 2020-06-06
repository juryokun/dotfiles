#!/bin/bash
source ~/dotfiles/init/setup_commands/env.sh

ln -snfv $ROOT/.bashrc ~/.bashrc
# {
#     echo "umask 022"
#     echo "alias lv='nvim -R'"
#     echo "export DOCKER_HOST='tcp://0.0.0.0:2375'"
#     echo "export PATH=\$PATH:~/bin"
# } >> ~/.bashrc
