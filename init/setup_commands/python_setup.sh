#!/bin/bash

# for linux
sudo apt-get install -y python-dev python-pip python3-dev python3-pip

sudo apt install -y build-essential
sudo apt install -y libffi-dev
sudo apt install -y libssl-dev
sudo apt install -y zlib1g-dev
sudo apt install -y liblzma-dev
sudo apt install -y libbz2-dev libreadline-dev libsqlite3-dev

# pyenv本体のダウンロードとインストール
sudo apt install -y git
git clone https://github.com/pyenv/pyenv.git ~/.pyenv


# for mac
brew install pyenv


# common
pyenv install --list
pyenv install 3.8.3
pyenv global 3.8.3

python -m pip install --upgrade pip
python -m pip install pynvim

mkdir ~/pyvenv
python -m venv ~/pyvenv/dev

mv ~/pyvenv/dev/bin/activate ~/pyvenv/dev/bin/activate.bash
mv ~/pyvenv/dev/bin/activate.fish ~/pyvenv/dev/bin/activate
souce ~/pyvenv/dev/bin/activate
python -m pip install --upgrade pip
python -m pip install pynvim
