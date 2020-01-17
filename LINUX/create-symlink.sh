#!/bin/bash

[ -f "$HOME/.gitconfig" ] && unlink "$HOME/.gitconfig"
[ -f "$HOME/.gitconfig-work" ] && unlink "$HOME/.gitconfig-work"
ln -snf ~/workspaces/rakesh-mth/dotfiles/GIT/.gitconfig ~/.gitconfig
ln -snf ~/workspaces/scripts/GIT/.gitconfig ~/.gitconfig-work

# symlink related to editors
[ -f "$HOME/.vimrc" ] && unlink "$HOME/.vimrc"
[ -f "$HOME/.config/nvim/init.vim" ] && unlink "$HOME/.config/nvim/init.vim"
ln -snf ~/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/init.vim ~/.vimrc
ln -snf ~/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/init.vim ~/.config/nvim/init.vim
