################################################################################
######INSTALL TOOLS USING CHOCO
#admin powershell
choco install -y neovim emacs vim fd ripgrep ag fzf bat ctags wget 7zip git gitversion.portable cmake powershell-core python2 python3 r.project r.studio groovy nodejs ruby jdk8 dotnetcore dotnetcore-sdk golang lua53 rustup.install rust-analyzer llvm hunspell.portable nuget.commandline jfrog-cli lxrunoffline libreoffice-fresh rufus nasm yasm jq
######pin a package (jfrog-cli) to the installed version (1.51.1 - last working)
choco pin add -n=jfrog-cli
######vim needs python version 3.7
choco install -y python --version=3.7.8
choco install -y python --version=3.8.5
rustup toolchain install stable-x86_64-pc-windows-msvc
################################################################################


################################################################################
######ADDITIONAL TOOLS
# powershell: git color on powershell prompt
Install-Module posh-git -Scope CurrentUser -force
Enable-GitColors
# install BuildTools for Visual Studio 2017 (do not need full VS)
https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=16
alternate link: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019
################################################################################


################################################################################
######CONFIGURE TOOLS (PYTHON, NODE AND RUBY) - require for vim
# user command prompt
py -2 -m pip install --user --upgrade pip
py -3.8 -m pip install --user --upgrade pip
py -2 -m pip install --user pynvim 
py -3.8 -m pip install --user pynvim neovim-remote virtualenvwrapper
npm install -g neovim tern typescript
gem install neovim
################################################################################


################################################################################
######VIRTUAL ENV PACKAGES. THESE PCKAGES ARE FOR VIM, EMACS AND ANY OTHER APPS.
REM install virtual env and python packages. using virtualenv command.
:: py -3.8 -m pip install --user virtualenvwrapper
:: virtualenv -p c:\Python38\python.exe %USERPROFILE%\virtualenvs\python38
:: %USERPROFILE%\virtualenvs\python38\scripts\activate
:: pip install pynvim neovim-remote flake8 isort yapf python-language-server pyls-isort pyls-mypy pyls-black importmagic epc ptvsd autoflake cmake-language-server
:: virtualenv -p c:\Python27\python.exe %USERPROFILE%\virtualenvs\python27
:: %USERPROFILE%\virtualenvs\python27\scripts\activate
:: pip install pynvim flake8 isort yapf python-language-server importmagic epc ptvsd autoflake
REM install virtual env and python packages. using mkvirtualenv command.
py -3 -m pip install virtualenvwrapper virtualenvwrapper-win
REM add user script folder of python in path
for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B
setx PATH "%my_user_path%;%USERPROFILE%\AppData\Roaming\Python\Python39\Scripts"
setx WORKON_HOME "%USERPROFILE%\virtualenvs" :: needed for mkvirtualenv and EMACS
FOR /F "tokens=* USEBACKQ" %%F IN (`where python ^| findstr Python39`) DO (SET python39=%%F)
mkvirtualenv -p "%python39%" python39 :: this will activate virtual env
pip install pynvim neovim-remote flake8 isort yapf python-language-server pyls-isort pyls-mypy pyls-black importmagic epc ptvsd autoflake cmake-language-server
FOR /F "tokens=* USEBACKQ" %%F IN (`where python ^| findstr Python27`) DO (SET python27=%%F)
mkvirtualenv -p "%python27%" python27 :: this will activate virtual env
pip install pynvim flake8 isort yapf python-language-server importmagic epc ptvsd autoflake
################################################################################


################################################################################
######ASPELL FOR WINDOWS (required for flyhcheck in spacemacs)
#download dictionary and extract it to c:\hunspell
mkdir c:\hunspell
cd c:\hunspell
wget http://downloads.sourceforge.net/wordlist/hunspell-en_US-2019.10.06.zip
7z e hunspell-en_US-2019.10.06.zip
################################################################################


################################################################################
######VIM
# font for vim
git clone https://github.com/powerline/fonts.git
# neovim (refer to init.vim for path), # using vs 2017 (use 14 for 2015)
cd %USERPROFILE%\.nvim\plugged\YouCompleteMe
python install.py --clang-completer --clangd-completer --go-completer --rust-completer --ts-completer --msvc 15
# for vim (refer to init.vim for path)
cd %USERPROFILE%\.vim\plugged\YouCompleteMe
python install.py --clang-completer --clangd-completer --go-completer --rust-completer --ts-completer --msvc 15
# neovim disable tabline (add option to shortcut)
nvim-qt --no-ext-tabline
################################################################################


################################################################################
######EMACS 
# install spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
# set HOME environment variable
setx HOME "%USERPROFILE%"
# enable unicode charset in cmd.exe (run on powershell)
sp -t d HKCU:\Console CodePage 0xfde9
# enable unicode charset in cmd.exe (per session)
chcp 65001
set SHELL=C:\ProgramData\chocolatey\lib\Emacs\tools\emacs\libexec\emacs\26.2\x86_64-w64-mingw32\cmdproxy.exe
# font for emacs
git clone https://github.com/adobe-fonts/source-code-pro.git
######EMACS COMMAND TO SWITCH VIRTUAL ENV
M-x pyvenv-workon (needs to be done before open a python file)
################################################################################


################################################################################
######POWERSHELL AZURE MODULE
Install-Module Az -Verbose
Get-InstalledModule -Name Az -AllVersions
Get-Module -Name Az* -ListAvailable
Get-Command *az* |measure
################################################################################

