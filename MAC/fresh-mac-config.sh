# install opengdk first as it is a dependency of groovy
brew cask install adoptopenjdk | tee ~/brew/adoptopenjdk
brew install neovim vim emacs fd ripgrep the_silver_searcher fzf ctags wget xz jfrog-cli-go python@2 python@3 groovy nodejs golang rust llvm cmake aspell hub git iperf3 gnupg
# brew cask install emacs 2>&1 | tee ~/brew/emacs

# create software folder for fonts and other opensource
mkdir -p ~/software 

################################################################################
######PYTHON
pip2 install --upgrade pip
pip3 install --upgrade pip
pip2 install --user pynvim
pip3 install --user pynvim neovim-remote virtualenvwrapper # add ~/Library/Python/3.7/bin in your path

################################################################################
######NPM AND NODE
npm install -g neovim tern typescript yarn

################################################################################
######RUBY
# add ~/.gem/ruby/2.6.0/bin in your path (change version number)
# install rvm
gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable # use \curl
rvm mount /usr/local/opt/ruby@3/bin/ruby # mount existing ruby from homebrew
# for ruby support in vim/nvim.
gem install --user-install neovim 
# for ruby development in spacemacs
gem install --user-install solargraph pry pry-doc ruby_parser rubocop prettier seeing_is_believing
# run `M-x dap-ruby-setup <enter>`
# for ruby development in vscode
gem install --user-install ruby-debug-ide
gem install --user-install debase -v 0.2.5.beta2
# vscode plugin for ruby
code --install-extension rebornix.ruby castwide.solargraph wingrunr21.vscode-ruby

################################################################################
######PYTHON
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
pip install pynvim neovim-remote flake8 isort yapf python-language-server pyls-isort pyls-mypy importmagic epc ptvsd autoflake 
################################################################################


################################################################################
######EMACS
# install spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
# font for emacs
git clone https://github.com/adobe-fonts/source-code-pro.git ~/software/source-code-pro
################################################################################


################################################################################
######VIM
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


