REM delete existing files or symlink
if exist "%USERPROFILE%"\.bashrc del "%USERPROFILE%"\.bashrc
if exist "%USERPROFILE%"\.gitconfig del "%USERPROFILE%"\.gitconfig
if exist "%USERPROFILE%"\.gitconfig-work del "%USERPROFILE%"\.gitconfig-work
if exist "%USERPROFILE%"\.wslconfig del "%USERPROFILE%"\.wslconfig
if exist "%USERPROFILE%"\.emacs del "%USERPROFILE%"\.emacs
if exist "%USERPROFILE%"\.emacs-profiles.el del "%USERPROFILE%"\.emacs-profiles.el
if exist "%USERPROFILE%"\.config\emacs\spacemacs\.spacemacs.d rmdir "%USERPROFILE%"\.config\emacs\spacemacs\.spacemacs.d
if exist "%USERPROFILE%"\.config\emacs\doom-emacs\.doom.d rmdir "%USERPROFILE%"\.config\emacs\doom-emacs\.doom.d
if exist "%USERPROFILE%"\.config\nvim\profiles.lua del "%USERPROFILE%"\.config\nvim\profiles.lua
if exist "%USERPROFILE%"\.vimrc del "%USERPROFILE%"\.vimrc
if exist "%USERPROFILE%"\AppData\Local\nvim\init.vim del "%USERPROFILE%"\AppData\Local\nvim\init.vim
if exist "%USERPROFILE%"\.config\nvim-config\rakesh-mth\init.vim del "%USERPROFILE%"\.config\nvim-config\rakesh-mth\init.vim
if exist "%USERPROFILE%"\.config\nvim-config\rakesh-mth\init.lua del "%USERPROFILE%"\.config\nvim-config\rakesh-mth\init.lua
if exist "%USERPROFILE%"\.vsvimrc del "%USERPROFILE%"\.vsvimrc

REM create folders for symlinks
if not exist "%USERPROFILE%"\AppData\Local\nvim mkdir "%USERPROFILE%"\AppData\Local\nvim
if not exist "%USERPROFILE%"\.vim mkdir "%USERPROFILE%"\.vim
if not exist "%USERPROFILE%"\.config\emacs\spacemacs mkdir "%USERPROFILE%"\.config\emacs\spacemacs
if not exist "%USERPROFILE%"\.config\emacs\doom-emacs mkdir "%USERPROFILE%"\.config\emacs\doom-emacs

SET SCRIPTS=f:\DevTrees\scripts
SET DOTFILES=f:\DevTrees\rakesh-mth\dotfiles

REM directory link from %DOTFILES%\WINDOWS\BATCH to f:\BATCH and from %SCRIPTS%\WINDOWS\BATCH to F:\BATCH-SCRIPTS
if not exist f:\BATCH mklink /D f:\BATCH %DOTFILES%\WINDOWS\BATCH
if not exist F:\BATCH-SCRIPTS mklink /D F:\BATCH-SCRIPTS %SCRIPTS%\WINDOWS\BATCH
REM add BATCH folders to path
for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B
setx PATH "%my_user_path%;f:\BATCH;f:\BATCH-SCRIPTS
REM directory link from F:\DevTrees to ~/workspaces
mklink /D "%USERPROFILE%"\workspaces F:\DevTrees
if not exist "%USERPROFILE%"\.bashrc mklink "%USERPROFILE%"\.bashrc %DOTFILES%\WINDOWS\.bashrc
if exist %SCRIPTS%\GIT\.gitconfig mklink "%USERPROFILE%"\.gitconfig-work %SCRIPTS%\GIT\.gitconfig
mklink "%USERPROFILE%"\.gitconfig %DOTFILES%\GIT\.gitconfig
mklink "%USERPROFILE%"\.wslconfig %DOTFILES%\WSL\.wslconfig
REM POWERSHELL profile
mklink %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 F:\DevTrees\scripts\WINDOWS\Powershell\Microsoft.PowerShell_profile.ps1
mklink %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 F:\DevTrees\scripts\WINDOWS\Powershell\Microsoft.PowerShell_profile.ps1
REM cheovim - clone the repo and create a symlink for profiles.lua file 
REM path is not "%USERPROFILE%"\.config\nvim on windows since that's not the default path for init.vim or init.lua on windows
if not exist "%USERPROFILE%"\AppData\Local\nvim git clone https://github.com/NTBBloodbath/cheovim "%USERPROFILE%"\AppData\Local\nvim
mklink "%USERPROFILE%"\AppData\Local\nvim\profiles.lua %DOTFILES%\EDITORS\VIM\profiles.lua
REM LunarVIm - clone the repo and create symlick for config.lua file
if not exist "%USERPROFILE%"\.config\nvim-config\LunarVim git clone https://github.com/LunarVim/LunarVim.git "%USERPROFILE%"\.config\nvim-config\LunarVim
mklink "%USERPROFILE%"\.config\nvim-config\LunarVim\config.lua %DOTFILES%\EDITORS\VIM\LunarVim\config.lua
mklink "%USERPROFILE%"\.vimrc %DOTFILES%\EDITORS\VIM\init.vim
REM svim - clone the repo
if not exist "%USERPROFILE%"\.config\nvim-config\svim git clone git@github.com:rakesh-mth/svim.git "%USERPROFILE%"\.config\nvim-config\svim
REM init.vim and init.lua symlink
mklink "%USERPROFILE%"\.config\nvim-config\rakesh-mth\init.vim %DOTFILES%\EDITORS\VIM\init.vim
mklink "%USERPROFILE%"\.config\nvim-config\rakesh-mth\init.lua %DOTFILES%\EDITORS\VIM\init.lua
mklink "%USERPROFILE%"\.vsvimrc %DOTFILES%\EDITORS\VIM\.vsvimrc
REM chemacs - spacemacs and doom-emacs
mklink "%USERPROFILE%"\.emacs %DOTFILES%\EDITORS\EMACS\.emacs
mklink "%USERPROFILE%"\.emacs-profiles.el %DOTFILES%\EDITORS\EMACS\.emacs-profiles.el
mklink /D "%USERPROFILE%"\.config\emacs\spacemacs\.spacemacs.d %DOTFILES%\EDITORS\EMACS\.spacemacs.d
mklink /D "%USERPROFILE%"\.config\emacs\doom-emacs\.doom.d %DOTFILES%\EDITORS\EMACS\.doom.d
REM set DOOMDIR env variable in current shell for `doom sync` and other doom commands
set DOOMDIR="%USERPROFILE%"\.config\emacs\doom-emacs\.doom.d
REM set DOOMDIR env variable permanently for `doom sync` and other doom commands
setx DOOMDIR "%USERPROFILE%"\.config\emacs\doom-emacs\.doom.d

REM SIMPLE emacs config
mklink "%APPDATA%"\.emacs %DOTFILES%\EDITORS\EMACS\simple\.emacs