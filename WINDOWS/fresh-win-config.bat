REM ################################################################################
REM ###### INSTALL TOOLS USING CHOCO
REM ###### admin powershell
choco install -y neovim emacs vim codeblocks fd ripgrep ag fzf bat ctags wget 7zip git gitversion.portable cmake powershell-core python2 python3 r.project r.studio groovy nodejs ruby jdk8 dotnetcore dotnetcore-sdk golang lua53 rustup.install rust-analyzer llvm hunspell.portable nuget.commandline jfrog-cli lxrunoffline libreoffice-fresh rufus nasm yasm 

REM ###### modern unit tools
choco install jq shellcheck zoxide delta lsd dust lazygit
REM ###### pin a package (jfrog-cli) to the installed version (1.51.1 - last working)
choco pin add -n=jfrog-cli
REM ###### install neovide and fvim editor frontend for neovim
REM download neovide and put it is path: https://github.com/neovide/neovide/releases/latest
REM download fvim and put it in path: https://github.com/yatli/fvim/releases/latest
REM ###### install glslang
REM # download, extract and add to path: https://github.com/KhronosGroup/glslang/releases/tag/master-tot
REM ###### install sbcl
REM # download and install: https://sourceforge.net/projects/sbcl/files/sbcl/2.1.10/
REM ###### vim needs python version 3.7
choco install -y python --version=3.7.8
choco install -y python --version=3.8.5
rustup toolchain install stable-x86_64-pc-windows-msvc
REM ################################################################################


REM ################################################################################
REM ###### ADDITIONAL TOOLS
REM powershell: git color on powershell prompt
Install-Module -Name posh-git -Scope CurrentUser -force
Add-PoshGitToProfile
REM powershell: install fzf extention for powershell
Install-Module -Name PSFzf -RequiredVersion 2.2.9
REM install BuildTools for Visual Studio 2017 (do not need full VS)
REM https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=16
REM alternate link: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019
REM ################################################################################


REM ################################################################################
REM ######CONFIGURE TOOLS (PYTHON, NODE, RUBY, GO) - require for vim and emacs
REM user command prompt
REM upgrade pip
py -2 -m pip install --user --upgrade pip
py -3.8 -m pip install --user --upgrade pip
REM install npm packages. npm modules path is added to PATH below, under python section.
REM marked, bash-language-server, typescript-language-server is used with doom-emacs
npm install -g neovim tern typescript yarn marked bash-language-server typescript-language-server
REM install gem packages
gem install neovim solargraph pry pry-doc ruby_parser rubocop prettier seeing_is_believing ruby-debug-ide debase
REM install go packages
REM default GOPATH is $HOME/go
REM These are for doom-emacs
go install github.com/x-motemen/gore/cmd/gore@latest
go install github.com/stamblerre/gocode@latest
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/cmd/gorename@latest
go install golang.org/x/tools/cmd/guru@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/fatih/gomodifytags@latest
REM ################################################################################


REM ################################################################################
REM ######VIRTUAL ENV PACKAGES. THESE PCKAGES ARE FOR VIM, EMACS AND ANY OTHER APPS.
REM install virtual env and python packages. using virtualenv command.
:: py -3.8 -m pip install --user virtualenvwrapper
:: virtualenv -p c:\Python38\python.exe %USERPROFILE%\virtualenvs\python38
:: %USERPROFILE%\virtualenvs\python38\scripts\activate
:: pip install pynvim neovim-remote flake8 isort yapf python-language-server pyls-isort pyls-mypy pyls-black importmagic epc ptvsd autoflake cmake-language-server
:: virtualenv -p c:\Python27\python.exe %USERPROFILE%\virtualenvs\python27
:: %USERPROFILE%\virtualenvs\python27\scripts\activate
:: pip install pynvim flake8 isort yapf python-language-server importmagic epc ptvsd autoflake
REM install virtual env and python packages. using mkvirtualenv command.
py -3 -m pip install wheel virtualenvwrapper virtualenvwrapper-win
REM add user script folder of python in path, and npm global module folder in path
for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B
setx PATH "%my_user_path%;%USERPROFILE%\AppData\Roaming\Python\Python39\Scripts;%USERPROFILE%\AppData\Roaming\npm\node_modules"
setx WORKON_HOME "%USERPROFILE%\virtualenvs" :: needed for mkvirtualenv and EMACS
FOR /F "tokens=* USEBACKQ" %%F IN (`where python ^| findstr Python39`) DO (SET python39=%%F)
mkvirtualenv -p "%python39%" python39 :: this will activate virtual env
pip install pynvim neovim-remote flake8 isort yapf python-language-server pyls-isort pyls-mypy pyls-black importmagic epc ptvsd autoflake cmake-language-server pytest pipenv nose :: pytest, pipenv and nose is added for UT in doom-emacs
FOR /F "tokens=* USEBACKQ" %%F IN (`where python ^| findstr Python27`) DO (SET python27=%%F)
mkvirtualenv -p "%python27%" python27 :: this will activate virtual env
pip install pynvim flake8 isort yapf python-language-server importmagic epc ptvsd autoflake
REM ################################################################################


REM ################################################################################
REM ######ASPELL FOR WINDOWS (required for flyhcheck in spacemacs)
REM download dictionary and extract it to c:\hunspell
mkdir c:\hunspell
cd c:\hunspell
wget http://downloads.sourceforge.net/wordlist/hunspell-en_US-2019.10.06.zip
7z e hunspell-en_US-2019.10.06.zip
REM ################################################################################


REM ################################################################################
REM ######VIM
REM clone cheovim (do not use ~/.config/nvim in windows since that's not the default location for init.vim or init.lua)
if not exist %USERPROFILE%\AppData\Local\nvim git clone https://github.com/NTBBloodbath/cheovim %USERPROFILE%\AppData\Local\nvim
REM clone doom-nvim (use develop branch)
if not exist %USERPROFILE%\.config\nvim-config\doom-nvim git clone --depth 1 -b develop https://github.com/NTBBloodbath/doom-nvim.git %USERPROFILE%\.config\nvim-config\doom-nvim
REM LunarVim (clone LunarVim)
if not exist %USERPROFILE%\.config\nvim-config\LunarVim git clone https://github.com/LunarVim/LunarVim.git %USERPROFILE%/.config/nvim-config/LunarVim
REM install plugins using PackerInstall. telescope-fzf-native will fail to compile. use next step to compile it. and run PackerInstall again.
REM use mingw64 or clang64 to compile fzf-native
cd ~/AppData/Local/nvim-data/site/pack/packer/start/telescope-fzf-native.nvim
make
REM font for vim
git clone https://github.com/powerline/fonts.git
REM neovim (refer to init.vim for path), # using vs 2017 (use 14 for 2015)
cd %USERPROFILE%\.nvim\plugged\YouCompleteMe
python install.py --clang-completer --clangd-completer --go-completer --rust-completer --ts-completer --msvc 15
REM for vim (refer to init.vim for path)
cd %USERPROFILE%\.vim\plugged\YouCompleteMe
python install.py --clang-completer --clangd-completer --go-completer --rust-completer --ts-completer --msvc 15
REM neovim disable tabline (add option to shortcut)
nvim-qt --no-ext-tabline
REM ################################################################################


REM ################################################################################
REM ######EMACS 
REM install spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
REM set HOME environment variable
setx HOME "%USERPROFILE%"
REM enable unicode charset in cmd.exe (run on powershell)
sp -t d HKCU:\Console CodePage 0xfde9
REM enable unicode charset in cmd.exe (per session)
chcp 65001
set SHELL=C:\ProgramData\chocolatey\lib\Emacs\tools\emacs\libexec\emacs\26.2\x86_64-w64-mingw32\cmdproxy.exe
REM font for emacs
git clone https://github.com/adobe-fonts/source-code-pro.git
REM ######EMACS COMMAND TO SWITCH VIRTUAL ENV
M-x pyvenv-workon (needs to be done before open a python file)
REM ################################################################################


REM ################################################################################
REM ######POWERSHELL AZURE MODULE
Install-Module Az -Verbose
Get-InstalledModule -Name Az -AllVersions
Get-Module -Name Az* -ListAvailable
Get-Command *az* |measure
REM ################################################################################

