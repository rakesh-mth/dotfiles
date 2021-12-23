#!/usr/bin/env bash

# symlink related to git config
[ -f "$HOME/.gitconfig" ] && unlink "$HOME/.gitconfig"
[ -f "$HOME/.gitconfig-work" ] && unlink "$HOME/.gitconfig-work"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/GIT/.gitconfig $HOME/.gitconfig
ln -snf $HOME/workspaces/scripts/GIT/.gitconfig $HOME/.gitconfig-work

# symlink related to editors
# neovim and vim
mkdir -p ~/temp # create temp folder for backup files in vim
mkdir -p "$HOME/.config/nvim"
[ -f "$HOME/.vimrc" ] && unlink "$HOME/.vimrc"
[ -f "$HOME/.config/nvim/init.vim" ] && unlink "$HOME/.config/nvim/init.vim"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/init.vim $HOME/.vimrc
# neovim will be using cheovim - do not create symlink for init.nvim
# ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/init.vim $HOME/.config/nvim/init.vim
# cheovim - clone the repo and create a symlink for profiles.lua file
[ ! -d $HOME/.config/nvim/ ] && git clone https://github.com/NTBBloodbath/cheovim $HOME/.config/nvim/
[ -f "$HOME/.config/nvim/profiles.lua" ] && unlink "$HOME/.config/nvim/profiles.lua"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/profiles.lua $HOME/.config/nvim/
# LunarVIm - clone the repo and create symlick for config.lua file
[ ! -d $HOME/.config/nvim-config/LunarVim ] && git clone https://github.com/LunarVim/LunarVim.git $HOME/.config/nvim-config/LunarVim
[ -f "$HOME/.config/nvim-config/LunarVim/config.lua" ] && unlink "$HOME/.config/nvim-config/LunarVim/config.lua"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/LunarVim/config.lua $HOME/.config/nvim-config/LunarVim/
# doom-nvim - clone the repo
[ ! -d $HOME/nvim-config/doom-nvim ] && git clone --depth 1 https://github.com/NTBBloodbath/doom-nvim.git $HOME/nvim-config/doom-nvim
# chemacs condif files
[ -f "$HOME/.emacs" ] && unlink "$HOME/.emacs"
[ -f "$HOME/.emacs-profiles.el" ] && unlink "$HOME/.emacs-profiles.el"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/EMACS/.emacs $HOME/.emacs
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/EMACS/.emacs-profiles.el $HOME/.emacs-profiles.el
# spacemacs
mkdir -p "$HOME/.config/emacs/spacemacs"
[ -d "$HOME/.config/emacs/spacemacs/.spacemacs.d" ] && rm -rf "$HOME/.config/emacs/spacemacs/.spacemacs.d"
mkdir -p "$HOME/.config/emacs/spacemacs/.spacemacs.d"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/EMACS/.spacemacs.d/init.el $HOME/.config/emacs/spacemacs/.spacemacs.d
# doom-emacs
mkdir -p "$HOME/.config/emacs/doom-emacs"
[ -f "$HOME/.config/emacs/doom-emacs/.doom.d" ] && unlink "$HOME/.config/emacs/doom-emacs/.doom.d"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/EMACS/.doom.d $HOME/.config/emacs/doom-emacs/.doom.d
# this is in .zshrc (it is here for current terminal)
export DOOMDIR=$HOME/.config/emacs/doom-emacs/.doom.d

# symlink related to shell. do not link .zshrc by default since it may override .zshrc from oh-my-zsh 
# do not replace .bashrc, instead source this bashrc into ~/.bashrc file towards the end.
# [ -f "$HOME/.zshrc" ] && unlink "$HOME/.zshrc"
# ln -snf $HOME/workspaces/rakesh-mth/dotfiles/.zshrc $HOME/.zshrc
# [ -f "$HOME/.bashrc" ] && unlink "$HOME/.bashrc"
# ln -snf $HOME/workspaces/rakesh-mth/dotfiles/.bashrc $HOME/.bashrc

