brew install vifm

rm -f ~/.config/vifm/vifmrc
rm -rf ~/.config/vifm/colors

git clone https://github.com/vifm/vifm-colors.git ~/.config/vifm/colors
git clone https://github.com/thimc/vifm_devicons.git ~/.config/vifm/vifm_devicons

ln -snfv ~/dotfiles/vifmrc ~/.config/vifm/vifmrc
