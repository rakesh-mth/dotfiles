#!/usr/bin/env bash

# define a color
RED='\033[0;31m'
GREEN='\033[0;32m'
# No Color
NC='\033[0m' 

# APT-GET
# apt-get (uninstalled, using brew for these packages)
# sudo add-apt-repository ppa:kelleyk/emacs
# sudo apt-get install htop tmux vim emacs27 

# snap (uninstalled, using brew for these packages)
# sudo snap install fzf-carroarmato0
# sudo snap install nvim --classic

# apt-get packages - avoid using apt-get, instead use brew packages
echo -e "${RED}updating apt mirror list${NC}"
sudo apt-get update
echo -e "${RED}installing apt packages${NC}"
sudo apt-get install -y openssh-server uswsusp

# HOMEBREW FOR LINUX
# brew path is added in ~/.profile by the installation.
# curl and git are needed for brew, can install brew version too
sudo apt-get install -y build-essential procps curl file git
if command -v brew &> /dev/null; then
    echo -e "${GREEN}brew is already installed${NC}"
else
    echo "installing brew..."
    mkdir -p $HOME/brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # upate current and future shell by adding path to brew
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # homebrew core:
    # aspell is used with spacemacs
    # xclip is used with neovim for copy paste from clipboard
    # virtualenv and virtualenvwrapper is installed for python virtual envs
    # gcc@5 is installed for compiling vterm module in doom-emacs
    # sbcl is common-lisp interpreter
    # glslang, jq, shellcheck is is installed for doom-emacs
    echo -e "${RED}installing packages using brew${NC}"
    # modern unix tools
    brew install bat lsd git-delta dust duf broot fd ripgrep the_silver_searcher fzf mcfly jq tldr bottom glances gtop zoxide lazygit | tee -a $HOME/brew/fresh-install
    # editors, compilers and tools
    brew install curl git htop tmux vim neovim emacs gcc@5 llvm rust rust-analyzer golang python@3.9 virtualenv virtualenvwrapper nodejs sbcl glslang cmake aspell iperf3 gnupg xclip shellcheck luarocks | tee -a $HOME/brew/fresh-install
    # homebrew cask: (is not supported on linux).
    # Error: Installing casks is supported only on macOS
    # brew install homebrew/cask/emacs
fi

# clone dotfiles repo from github
if [ ! -d "$HOME/workspaces/rakesh-mth" ]; then
    git clone https://github.com/rakesh-mth/dotfiles.git $HOME/workspaces/rakesh-mth
fi

# CREATE SYMLINKS
create_symlink=$(readlink -f $(dirname "$0")/create-symlink.sh)
echo -e "${RED}running $create_symlink${NC}"
source $create_symlink

# source .bashrc and .zshrc to ~/.bashrc and ~/.zshrc
shell_config_file=".zshrc"
[ "$SHELL" = "/bin/bash" ] && shell_config_file=".bashrc"
config_file=$(readlink -f $(dirname "$0")/../$shell_config_file)
bashrc_content="source $config_file"
echo -e "${RED}adding source $config_file${NC}"
if ! grep -qF "$bashrc_content" $HOME/$shell_config_file ; then
    echo "$bashrc_content" >> $HOME/$shell_config_file
    source "$config_file" # source for PATH and env variables in current shell
fi

# RUST
cargo install stylua # formatter for lua

# LUA
luarocks install luacheck

# PYTHON 
# path must match with config.vim in vim-user-config repo
python3=python3.9
if [ ! -d "$HOME/.virtualenvs/$python3" ]; then
    # do not use virtualenv directly, instead use mkvirtualenv
    # virtualenv -p /home/linuxbrew/.linuxbrew/bin/$python3 $HOME/.virtualenvs/$python3
    # source $HOME/.virtualenvs/$python3/bin/activate
    # mkvirtualenv creates env under $HOME/.virtualenvs
    echo -e "${RED}creating python virtual env for $python3${NC}"
    # source virtualenvwrapper.sh to bring mkvirtualenv and workon
    source virtualenvwrapper.sh
    mkvirtualenv -p /home/linuxbrew/.linuxbrew/bin/$python3 $python3
    # activate python virtual env
    workon $python3
    # install all python modules for vim, neovim and emacs developments.
    # pytest, pipenv and nose is added for UT in doom-emacs. ipython is for python repl in doom emacs.

    pip install pynvim neovim-remote flake8 isort yapf python-language-server[all] pyls-isort pyls-mypy importmagic epc ptvsd autoflake pytest pipenv nose ipython black
    # deactivate python virtual env.
    deactivate
else
    echo -e "${GREEN}virtual env for $python3 already exists.${NC}"
fi

# RUBY (with RVM)
if [ ! -d "$HOME/.rvm" ]; then
    RUBY_VERSION=3.0.3
    echo -e "${RED}creating RVM env for $RUBY_VERSION${NC}"
    curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
    # source rvm path in current shell. for future shell it will be part of .bashrc / .zshrc
    source /home/rakesh/.rvm/scripts/rvm 
    # install ruby-3.0.3 using rvm
    rvm install ruby-$RUBY_VERSION --binary
    # switch to use ruby from rvm. This will be default in all shell now onwards.
    rvm use $RUBY_VERSION
    # install gems (--user-install option is not used if rvm is used)
    gem install neovim solargraph pry pry-doc ruby_parser rubocop prettier seeing_is_believing ruby-debug-ide debase
else
    echo -e "${GREEN}rvm is already installed${NC}"
fi

# NPM and NODEJS
if [ ! -d "$HOME/.nvm" ]; then
    NODE_VERSION=17.1.0
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    # source nvm in current shell. for future shell it will be part of .bashrc / .zshrc
    source "$HOME/.nvm/nvm.sh"
    # install a node 
    nvm install $NODE_VERSION
    # switch to use npm from nvm. This will be default in all shell now onwards.
    nvm use $NODE_VERSION
    # marked, bash-language-server, typescript-language-server is used with doom-emacs
    npm install -g neovim tern typescript yarn marked bash-language-server typescript-language-server
else
    echo -e "${GREEN}nvm is already installed${NC}"
fi

# GO LANG
# default GOPATH is $HOME/go
# These are for doom-emacs
echo -e "${RED}installing go tools${NC}"
! command -v gore &> /dev/null && go install github.com/x-motemen/gore/cmd/gore@latest
! command -v gocode &> /dev/null && go install github.com/stamblerre/gocode@latest
! command -v godoc &> /dev/null && go install golang.org/x/tools/cmd/godoc@latest
! command -v goimports &> /dev/null && go install golang.org/x/tools/cmd/goimports@latest
! command -v gorename &> /dev/null && go install golang.org/x/tools/cmd/gorename@latest
! command -v guru &> /dev/null && go install golang.org/x/tools/cmd/guru@latest
! command -v gotests &> /dev/null && go install github.com/cweill/gotests/gotests@latest
! command -v gomodifytags &> /dev/null && go install github.com/fatih/gomodifytags@latest

# VIM
# clone cheovim
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/NTBBloodbath/cheovim ~/.config/nvim/
else
    echo -e "${GREEN}cheovim is already cloned${NC}"
fi
# clone LunarVim
if [ ! -d $HOME/.config/nvim-config/LunarVim ]; then
    git clone https://github.com/LunarVim/LunarVim.git $HOME/.config/nvim-config/LunarVim
else
    echo -e "${GREEN}LunarVim is already cloned${NC}"
fi
# clone doom-nvim
if [ ! -d "$HOME/.config/nvim-config/doom-nvim" ]; then
    git clone --depth 1 https://github.com/NTBBloodbath/doom-nvim.git $HOME/.config/nvim-config/doom-nvim
else
    echo -e "${GREEN}doom-nvim is already cloned${NC}"
fi

# EMACS
# clone spacemacs (path must match from create-symlink.sh)
if [ ! -d "$HOME/.config/emacs/spacemacs/.emacs.d" ]; then
    echo "cloning spacemacs"
    git clone https://github.com/syl20bnr/spacemacs ~/.config/emacs/spacemacs/.emacs.d
else
    echo -e "${GREEN}spacemacs is already cloned${NC}"
fi
# clone doom-emacs (path must match from create-symlink.sh)
if [ ! -d "$HOME/.config/emacs/doom-emacs/.emacs.d" ]; then
    echo "cloning doom-emacs"
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs/doom-emacs/.emacs.d
else
    echo -e "${GREEN}doom-emacs is already cloned${NC}"
fi


# key gen from github (only once, not on all machine)
# ssh-keygen -t ed25519 -C "rakesh.mth@gmail.com"

