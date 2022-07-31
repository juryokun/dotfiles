#!/usr/bin/fish
set ROOT ~/dotfiles

ln -snfv $ROOT/config.fish ~/.config/fish/config.fish
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

fisher install jethrokuan/fzf
fisher install 0rax/fish-bd
fisher install oh-my-fish/theme-bobthefish
decors/fish-ghq
# fisher install jethrokuan/z
