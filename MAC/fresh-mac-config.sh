brew install neovim vim fd ripgrep the_silver_searcher fzf ctags wget xz python@2 python@3 nodejs golang rust aspell 2>&1 | tee ~/brew/fresh-mac-config
brew cask install emacs 2>&1 | tee ~/brew/emacs


pip2 install --upgrade pip
pip3 install --upgrade pip
pip2 install --user pynvim
pip3 install --user pynvim neovim-remote virtualenvwrapper

npm install -g neovim tern typescript
gem install --user-install neovim # add ~/.gem/ruby/2.6.0/bin in your path (change version number)

