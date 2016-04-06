#!/bin/bash

ln -s `realpath -sm .vimrc` ~/.vimrc

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


