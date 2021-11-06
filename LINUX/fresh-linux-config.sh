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
brew install curl git htop tmux vim neovim emacs fd bat ripgrep the_silver_searcher fzf llvm rust golang nodejs cmake aspell iperf3 gnupg
# homebrew cask (is not supported on linux). 
# Error: Installing casks is supported only on macOS
# brew install homebrew/cask/emacs

# key gen from github (only once, not on all machine)
# ssh-keygen -t ed25519 -C "rakesh.mth@gmail.com"

