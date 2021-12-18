# install opengdk first as it is a dependency of groovy
brew cask install adoptopenjdk | tee ~/brew/adoptopenjdk
# install modern unix tools
brew tap cantino/mcfly
brew install lsd git-delta dust duf broot fd ripgrep the_silver_searcher fzf mcfly jq 
# some packages available using npm or other package manager, do not install them using brew.
# list of packages not to be installed using brew: marked
brew install neovim vim emacs ctags wget xz jfrog-cli-go python@2 python@3 groovy nodejs golang rust rust-analyzer llvm sbcl glslang cmake aspell hub git iperf3 gnupg shellcheck coreutils fontconfig
# brew cask install emacs 2>&1 | tee ~/brew/emacs

# create software folder for fonts and other opensource
mkdir -p ~/software 

################################################################################
###### PYTHON
# update system pip and install virtualenvwrapper
pip2 install --upgrade pip
pip3 install --upgrade pip
pip2 install --user pynvim
pip3 install --user pynvim neovim-remote virtualenvwrapper # add ~/Library/Python/3.7/bin in your path
# use mkvirtualenv command to add a virtual env
mkvirtualenv -p /usr/local/bin/python2.7 python2.7
mkvirtualenv -p /usr/local/bin/python3.8 python3.8
mkvirtualenv -p /usr/local/bin/python3.9 python3.9
# switch to a virtualenv
workon python3.8
#deactivate a virtualenv
deactivate
# remove a virtual env with rmvirtualenv
rmvirtualenv python2.7
# install python packages in virtualenv - required for python development (do not use virtualenv directly)
virtualenv -p /usr/local/bin/python2.7 $HOME/.virtualenvs/python2.7
virtualenv -p /usr/local/bin/python3.7 $HOME/.virtualenvs/python3.7
# work related development
source $HOME/virtualenvs/python27/bin/activate
pip install pynvim setuptools dagger enum pyOpenSSL PyYAML requests decorator networkx==1.10 
# python development in emacs or vim
source $HOME/virtualenvs/python37/bin/activate
# flake8 is not installed because this is conflicting with autopep8 on version of pycodestyle
pip install pynvim neovim-remote isort yapf python-language-server pyls-isort pyls-mypy importmagic epc ptvsd autoflake 
# for python with eglot in doom-emacs. pytest, pipenv and nose is added for UT in doom-emacs. ipython is for python repl in doom emacs.
pip install autopep8 pydocstyle pylint rope future pytest pipenv nose ipython
################################################################################

################################################################################
###### RUBY (with RVM)
if [ ! -d "$HOME/.rvm" ]; then
    RUBY_VERSION=3.0.3
    # install rvm. most likely gpg key is not needed
    gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    # curl -sSL https://get.rvm.io | bash -s stable
    curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
    # source rvm in current shell
    source "$HOME/.rvm/scripts/rvm"
    # mount existing ruby from homebrew. import gem will fail for bundler, run below command to install it.
    rvm mount /usr/local/opt/ruby@3/bin/ruby
    sudo gem install rubygems-bundler # bundler fails to install, needs sudo access for /us/local folder.
    # install ruby-3.0.3 using rvm, --binary option does not find a pre-build binary in mac
    rvm install ruby-$RUBY_VERSION # --binary
    # switch to use ruby from rvm. This will be default in all shell now onwards.
    rvm --default use $RUBY_VERSION
    # install gems (--user-install option is not used if rvm is used)
    # for ruby support in vim, nvim, spacemacs, doom-emacs
    # gem for ruby development in vscode: ruby-debug-ide, debase
    gem install neovim solargraph pry pry-doc ruby_parser rubocop prettier seeing_is_believing ruby-debug-ide
    gem install debase -v 0.2.5.beta2
    # emacs: configure ruby for debugging
    # run `M-x dap-ruby-setup <enter>`
    # vscode: plugin for ruby
    code --install-extension rebornix.ruby castwide.solargraph wingrunr21.vscode-ruby
else
    echo "rvm is already installed"
fi
################################################################################

################################################################################
###### NPM and NODEJS (with NVM)
if [ ! -d "$HOME/.nvm" ]; then
    NODE_VERSION=17.1.0
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    # source nvm in current shell
    source "$HOME/.nvm/nvm.sh"
    # install a node 
    nvm install $NODE_VERSION
    # switch to use npm from nvm. This will be default in all shell now onwards.
    nvm use $NODE_VERSION
    # marked, bash-language-server, typescript-language-server is used with doom-emacs
    npm install -g neovim tern typescript yarn marked bash-language-server typescript-language-server
    # install modern unix tools
    npm install -g tldr
else
    echo "nvm is already installed"
fi
################################################################################

################################################################################
###### GO LANG
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
# go language lint server and client for neovim and vim
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
################################################################################

################################################################################
###### EMACS
# install spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
# font for emacs
git clone https://github.com/adobe-fonts/source-code-pro.git ~/software/source-code-pro
################################################################################

################################################################################
###### VIM
# font for vim
git clone https://github.com/powerline/fonts.git ~/software/fonts
# repeat key sequence (ex: repeat j/k in vscode vim movement)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# neovim (refer to init.vim for path), # using vs 2017 (use 14 for 2015)
cd $HOME/.nvim/plugged/YouCompleteMe
python install.py --clang-completer --clangd-completer --go-completer --rust-completer --ts-completer
# for vim (refer to init.vim for path)
cd $HOME/.vim/plugged/YouCompleteMe
python install.py --clang-completer --clangd-completer --go-completer --rust-completer --ts-completer
################################################################################


