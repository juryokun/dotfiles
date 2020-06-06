#!/bin/bash
source ~/dotfiles/init/setup_commands/env.sh

# for linux
git clone https://github.com/powerline/fonts.git --depth=1 $WORK_DIR/fonts
cd $WORK_DIR/fonts
./install.sh

# for mac
brew tap sanemat/font
brew install ricty --with-powerline
