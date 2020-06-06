#!/bin/bash
source ~/dotfiles/init/setup_commands/env.sh

if [ -e $ROOT/.config/nvim ]; then
    ln -snfv $ROOT/nvim ~/.config/nvim
fi

