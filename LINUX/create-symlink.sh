#!/bin/bash

# symlink related to git config
[ -f "$HOME/.gitconfig" ] && unlink "$HOME/.gitconfig"
[ -f "$HOME/.gitconfig-work" ] && unlink "$HOME/.gitconfig-work"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/GIT/.gitconfig $HOME/.gitconfig
ln -snf $HOME/workspaces/scripts/GIT/.gitconfig $HOME/.gitconfig-work

# symlink related to editors
[ -f "$HOME/.vimrc" ] && unlink "$HOME/.vimrc"
[ -f "$HOME/.config/nvim/init.vim" ] && unlink "$HOME/.config/nvim/init.vim"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/init.vim $HOME/.vimrc
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/init.vim $HOME/.config/nvim/init.vim
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

# symlink related to shell
[ -f "$HOME/.zshrc" ] && unlink "$HOME/.zshrc"
[ -f "$HOME/.bashrc" ] && unlink "$HOME/.bashrc"
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/.zshrc $HOME/.zshrc
ln -snf $HOME/workspaces/rakesh-mth/dotfiles/.bashrc $HOME/.bashrc
