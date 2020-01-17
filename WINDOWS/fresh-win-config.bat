#admin powershell
choco install -y neovim emacs vim fd ripgrep ag fzf ctags wget 7zip git python2 python3 nodejs ruby golang rust llvm hunspell.portable
# vim needs python version 3.7 
choco install -y python --version=3.7.3

# install BuildTools for Visual Studio 2017 (do not need full VS)
https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=16
alternate link: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019

# user command prompt
py -2 -m pip install --upgrade pip
py -3.7 -m pip install --upgrade pip
py -2 -m pip install --user pynvim neovim-remote
py -3.7 -m pip install --user pynvim neovim-remote virtualenvwrapper
npm install -g neovim tern typescript
gem install neovim

# add user script folder of python in path
for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B
setx PATH "%my_user_path%;%USERPROFILE%\AppData\Roaming\Python\Python37\Scripts"

#download dictionary and extract it to c:\hunspell
mkdir c:\hunspell
cd c:\hunspell
wget http://downloads.sourceforge.net/wordlist/hunspell-en_US-2019.10.06.zip
7z e hunspell-en_US-2019.10.06.zip


# install spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# font for emacs
git clone https://github.com/adobe-fonts/source-code-pro.git
# font for vim
git clone https://github.com/powerline/fonts.git

################################################################################
######VIM
# neovim (refer to init.vim for path), # using vs 2017 (use 14 for 2015)
cd %USERPROFILE%\.nvim\plugged\YouCompleteMe
python install.py --clang-completer --clangd-completer --go-completer --rust-completer --ts-completer --msvc 15
# for vim (refer to init.vim for path)
cd %USERPROFILE%\.vim\plugged\YouCompleteMe
python install.py --clang-completer --clangd-completer --go-completer --rust-completer --ts-completer --msvc 15
################################################################################


################################################################################
######EMACS 
# install python packages in virtualenv - required for python development
py -3.7 -m pip install --user virtualenvwrapper
virtualenv -p c:\Python37\python.exe %USERPROFILE%\python-envs\python37
virtualenv -p c:\Python27\python.exe %USERPROFILE%\python-envs\python27
setx WORKON_HOME "%USERPROFILE%\python-envs"
cd %USERPROFILE%\python-envs\python37\scripts
mklink python3 python.exe
%USERPROFILE%\python-envs\python37\scripts\activate
pip install flake8 isort yapf python-language-server pyls-isort pyls-mypy importmagic epc ptvsd autoflake
######EMACS COMMAND TO SWITCH VIRTUAL ENV
M-x pyvenv-workon (needs to be done before open a python file)
################################################################################

