#!/bin/bash

# for linux
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim

# for mac
brew install neovim
