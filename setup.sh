#!/bin/bash

ln -s `realpath -sm init.vim` ~/.config/nvim/init.vim

mkdir -p ~/.config/nvim/undo
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
