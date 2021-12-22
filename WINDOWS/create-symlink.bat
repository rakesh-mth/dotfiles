REM delete existing files or symlink
if exist %USERPROFILE%\.bashrc del %USERPROFILE%\.bashrc
if exist %USERPROFILE%\.gitconfig del %USERPROFILE%\.gitconfig
if exist %USERPROFILE%\.gitconfig-work del %USERPROFILE%\.gitconfig-work
if exist %USERPROFILE%\.wslconfig del %USERPROFILE%\.wslconfig
if exist %USERPROFILE%\.emacs del %USERPROFILE%\.emacs
if exist %USERPROFILE%\.emacs-profiles.el del %USERPROFILE%\.emacs-profiles.el
if exist %USERPROFILE%\.config\emacs\spacemacs\.spacemacs.d rmdir %USERPROFILE%\.config\emacs\spacemacs\.spacemacs.d
if exist %USERPROFILE%\.config\emacs\doom-emacs\.doom.d rmdir %USERPROFILE%\.config\emacs\doom-emacs\.doom.d
if exist %USERPROFILE%\.config\nvim\profiles.lua del %USERPROFILE%\.config\nvim\profiles.lua
if exist %USERPROFILE%\.vimrc del %USERPROFILE%\.vimrc
if exist %USERPROFILE%\AppData\Local\nvim\init.vim del %USERPROFILE%\AppData\Local\nvim\init.vim
if exist %USERPROFILE%\.vsvimrc del %USERPROFILE%\.vsvimrc

REM create folders for symlinks
if not exist %USERPROFILE%\AppData\Local\nvim mkdir %USERPROFILE%\AppData\Local\nvim
if not exist %USERPROFILE%\.vim mkdir %USERPROFILE%\.vim
if not exist %USERPROFILE%\.config\emacs\spacemacs mkdir %USERPROFILE%\.config\emacs\spacemacs
if not exist %USERPROFILE%\.config\emacs\doom-emacs mkdir %USERPROFILE%\.config\emacs\doom-emacs

SET SCRIPTS=f:\DevTrees\scripts
SET DOTFILES=f:\DevTrees\rakesh-mth\dotfiles

mklink %USERPROFILE%\.bashrc %DOTFILES%\WINDOWS\.bashrc
if exist %SCRIPTS%\GIT\.gitconfig mklink %USERPROFILE%\.gitconfig-work %SCRIPTS%\GIT\.gitconfig
mklink %USERPROFILE%\.gitconfig %DOTFILES%\GIT\.gitconfig
mklink %USERPROFILE%\.wslconfig %DOTFILES%\WSL\.wslconfig
REM cheovim - for nvim
mklink %USERPROFILE%\.config\nvim\profiles.lua %DOTFILES%\EDITORS\VIM\profiles.lua
mklink %USERPROFILE%\.vimrc %DOTFILES%\EDITORS\VIM\init.vim
mklink %USERPROFILE%\AppData\Local\nvim\init.vim %DOTFILES%\EDITORS\VIM\init.vim
mklink %USERPROFILE%\.vsvimrc %DOTFILES%\EDITORS\VIM\.vsvimrc
REM chemacs - spacemacs and doom-emacs
mklink %USERPROFILE%\.emacs %DOTFILES%\EDITORS\EMACS\.emacs
mklink %USERPROFILE%\.emacs-profiles.el %DOTFILES%\EDITORS\EMACS\.emacs-profiles.el
mklink /D %USERPROFILE%\.config\emacs\spacemacs\.spacemacs.d %DOTFILES%\EDITORS\EMACS\.spacemacs.d
mklink /D %USERPROFILE%\.config\emacs\doom-emacs\.doom.d %DOTFILES%\EDITORS\EMACS\.doom.d
REM set DOOMDIR env variable in current shell for `doom sync` and other doom commands
set DOOMDIR=%USERPROFILE%\.config\emacs\doom-emacs\.doom.d
REM set DOOMDIR env variable permanently for `doom sync` and other doom commands
setx DOOMDIR %USERPROFILE%\.config\emacs\doom-emacs\.doom.d
