# apt-get (uninstalled, using brew for these packages)
# sudo add-apt-repository ppa:kelleyk/emacs
# sudo apt-get install htop tmux vim emacs27 

# apt-get (needed for brew, can install brew version too)
sudo apt-get install curl git uswsusp

# snap (uninstalled, using brew for these packages)
# sudo snap install fzf-carroarmato0
# sudo snap install nvim --classic

# homebrew for linux
sudo apt-get install build-essential procps curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# homebrew core
# aspell is used with spacemacs
# xclip is used with neovim for copy paste from clipboard
# virtualenv is installed for python virtual envs
brew install curl git htop tmux vim neovim emacs fd bat ripgrep the_silver_searcher fzf llvm rust golang nodejs cmake aspell iperf3 gnupg virtualenv xclip
# homebrew cask (is not supported on linux). 
# Error: Installing casks is supported only on macOS
# brew install homebrew/cask/emacs


# python (path must match with config.vim in vim-user-config repo)
virtualenv -p /home/linuxbrew/.linuxbrew/bin/python3.9 $HOME/.virtualenvs/python3.9
source /home/rakesh/.virtualenvs/python3.9/bin/activate
# install all python modules for vim, neovim and emacs developments
pip install pynvim neovim-remote flake8 isort yapf python-language-server pyls-isort pyls-mypy importmagic epc ptvsd autoflake


# EMACS
# clone spacemacs (path must match from create-symlink.sh)
git clone https://github.com/syl20bnr/spacemacs ~/.config/emacs/spacemacs/.emacs.d
# clone doom-emacs (path must match from create-symlink.sh)
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs/doom-emacs/.emacs.d


# key gen from github (only once, not on all machine)
# ssh-keygen -t ed25519 -C "rakesh.mth@gmail.com"

