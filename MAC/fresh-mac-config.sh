brew install neovim vim fd ripgrep the_silver_searcher fzf ctags wget xz python@2 python@3 nodejs golang rust llvm cmake aspell 2>&1 | tee ~/brew/fresh-mac-config
brew cask install emacs 2>&1 | tee ~/brew/emacs


pip2 install --upgrade pip
pip3 install --upgrade pip
pip2 install --user pynvim
pip3 install --user pynvim neovim-remote virtualenvwrapper # add ~/Library/Python/3.7/bin in your path

npm install -g neovim tern typescript yarn
gem install --user-install neovim # add ~/.gem/ruby/2.6.0/bin in your path (change version number)


# install spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# create software folder for fonts and other opensource
mkdir -p ~/software
# font for emacs
git clone https://github.com/adobe-fonts/source-code-pro.git ~/software/source-code-pro
# font for vim
git clone https://github.com/powerline/fonts.git ~/software/fonts

################################################################################
######EMACS
# install python packages in virtualenv - required for python development
virtualenv -p /usr/local/bin/python3.7 $HOME/virtualenvs/python37
source $HOME/virtualenvs/python37/bin/activate
pip install flake8 isort yapf python-language-server pyls-isort pyls-mypy importmagic epc ptvsd autoflake
################################################################################
