#!/usr/bin/env bash

# close dotfiles repo from github
if [ ! -d "$HOME/workspaces/rakesh-mth" ]; then
    mkdir -p $HOME/workspaces/rakesh-mth
    pushd $HOME/workspaces/rakesh-mth
    git clone https://github.com/rakesh-mth/dotfiles.git
    popd
fi

# CREATE SYMLINKS
create_symlink=$(readlink -f $(dirname "$0")/create-symlink.sh)
echo "running $create_symlink"
source $create_symlink

# source .bashrc and .zshrc to ~/.bashrc and ~/.zshrc
bashrc_file=$(readlink -f $(dirname "$0")/../.bashrc)
bashrc_content="source $bashrc_file"
echo "adding source $bashrc_file"
if ! grep -qF "$bashrc_content" $HOME/.bashrc ; then
    echo "$bashrc_content" >> $HOME/.bashrc
    source "$bashrc_content" # source for PATH and env variables in current shell
fi


# APT-GET
# apt-get (uninstalled, using brew for these packages)
# sudo add-apt-repository ppa:kelleyk/emacs
# sudo apt-get install htop tmux vim emacs27 

# snap (uninstalled, using brew for these packages)
# sudo snap install fzf-carroarmato0
# sudo snap install nvim --classic

# apt-get packages - avoid using apt-get, instead use brew packages
sudo apt-get install uswsusp

# HOMEBREW FOR LINUX
# brew path is added in ~/.profile by the installation.
# curl and git are needed for brew, can install brew version too
sudo apt-get install build-essential procps curl file git
if command -v brew &> /dev/null; then
    echo "brew is already installed"
else
    echo "installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # homebrew core:
    # aspell is used with spacemacs
    # xclip is used with neovim for copy paste from clipboard
    # virtualenv and virtualenvwrapper is installed for python virtual envs
    # gcc@5 is installed for compiling vterm module in doom-emacs
    # sbcl is common-lisp interpreter
    # glslang, jq, shellcheck is is installed for doom-emacs
    echo "installing packages using brew"
    brew install curl git htop tmux vim neovim emacs fd bat ripgrep the_silver_searcher fzf gcc@5 llvm rust rust-analyzer golang python virtualenv virtualenvwrapper nodejs sbcl glslang cmake aspell iperf3 gnupg xclip jq shellcheck
    # homebrew cask: (is not supported on linux).
    # Error: Installing casks is supported only on macOS
    # brew install homebrew/cask/emacs
fi


# PYTHON 
# path must match with config.vim in vim-user-config repo
python3=python3.9
if [ ! -d "$HOME/.virtualenvs/$python3" ]; then
    # do not use virtualenv directly, instead use mkvirtualenv
    # virtualenv -p /home/linuxbrew/.linuxbrew/bin/$python3 $HOME/.virtualenvs/$python3
    # source $HOME/.virtualenvs/$python3/bin/activate
    # mkvirtualenv creates env under $HOME/.virtualenvs
    echo "creating python virtual env for $python3"
    mkvirtualenv -p /home/linuxbrew/.linuxbrew/bin/$python3 $python3
    # activate python virtual env
    workon $python3
    # install all python modules for vim, neovim and emacs developments.
    pip install pynvim neovim-remote flake8 isort yapf python-language-server[all] pyls-isort pyls-mypy importmagic epc ptvsd autoflake pytest pipenv nose # pytest, pipenv and nose is added for UT in doom-emacs
    # deactivate python virtual env.
    deactivate
else
    echo "virtual env for $python3 already exists."
fi

# NPM and NODEJS
# marked, bash-language-server, typescript-language-server is used with doom-emacs
npm install -g neovim tern typescript yarn marked bash-language-server typescript-language-server

# GO LANG
# default GOPATH is $HOME/go
# These are for doom-emacs
go install github.com/x-motemen/gore/cmd/gore@latest
go install github.com/stamblerre/gocode@latest
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/cmd/gorename@latest
go install golang.org/x/tools/cmd/guru@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/fatih/gomodifytags@latest

# EMACS
# clone spacemacs (path must match from create-symlink.sh)
if [ ! -d "$HOME/.config/emacs/spacemacs/.emacs.d" ]; then
    echo "cloning spacemacs"
    git clone https://github.com/syl20bnr/spacemacs ~/.config/emacs/spacemacs/.emacs.d
else
    echo "spacemacs is already cloned"
fi
# clone doom-emacs (path must match from create-symlink.sh)
if [ ! -d "$HOME/.config/emacs/doom-emacs/.emacs.d" ]; then
    echo "cloning doom-emacs"
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs/doom-emacs/.emacs.d
else
    echo "doom-emacs is already cloned"
fi


# key gen from github (only once, not on all machine)
# ssh-keygen -t ed25519 -C "rakesh.mth@gmail.com"

