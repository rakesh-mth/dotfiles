if exist %USERPROFILE%\.gitconfig del %USERPROFILE%\.gitconfig
if exist %USERPROFILE%\.gitconfig-work del %USERPROFILE%\.gitconfig-work
if exist %USERPROFILE%\.wslconfig del %USERPROFILE%\.wslconfig
if exist %USERPROFILE%\.emacs del %USERPROFILE%\.emacs
if exist %USERPROFILE%\.emacs-profiles.el del %USERPROFILE%\.emacs-profiles.el
if exist %USERPROFILE%\emacs\spacemacs\.spacemacs.d rmdir %USERPROFILE%\emacs\spacemacs\.spacemacs.d
if exist %USERPROFILE%\emacs\doom-emacs\.doom.d rmdir %USERPROFILE%\emacs\doom-emacs\.doom.d
if exist %USERPROFILE%\.vimrc del %USERPROFILE%\.vimrc
if exist %USERPROFILE%\AppData\Local\nvim\init.vim del %USERPROFILE%\AppData\Local\nvim\init.vim

if not exist %USERPROFILE%\AppData\Local\nvim mkdir %USERPROFILE%\AppData\Local\nvim
if not exist %USERPROFILE%\.vim mkdir %USERPROFILE%\.vim
if not exist %USERPROFILE%\emacs\spacemacs mkdir %USERPROFILE%\emacs\spacemacs
if not exist %USERPROFILE%\emacs\doom-emacs mkdir %USERPROFILE%\emacs\doom-emacs

SET SCRIPTS=f:\DevTrees\scripts
SET DOTFILES=f:\DevTrees\rakesh-mth\dotfiles

mklink %USERPROFILE%\.gitconfig-work %SCRIPTS%\GIT\.gitconfig
mklink %USERPROFILE%\.gitconfig %DOTFILES%\GIT\.gitconfig
mklink %USERPROFILE%\.wslconfig %DOTFILES%\WSL\.wslconfig
mklink %USERPROFILE%\.vimrc %DOTFILES%\EDITORS\VIM\init.vim
mklink %USERPROFILE%\AppData\Local\nvim\init.vim %DOTFILES%\EDITORS\VIM\init.vim
REM chemacs - spacemacs and doom-emacs
mklink %USERPROFILE%\.emacs %DOTFILES%\EDITORS\EMACS\.emacs
mklink %USERPROFILE%\.emacs-profiles.el %DOTFILES%\EDITORS\EMACS\.emacs-profiles.el
mklink /D %USERPROFILE%\emacs\spacemacs\.spacemacs.d %DOTFILES%\EDITORS\EMACS\.spacemacs.d
mklink /D %USERPROFILE%\emacs\doom-emacs\.doom.d %DOTFILES%\EDITORS\EMACS\.doom.d
REM set DOOMDIR env variable in current shell for `doom sync` and other doom commands
set DOOMDIR=%USERPROFILE%\emacs\doom-emacs\.doom.d
REM set DOOMDIR env variable permanently for `doom sync` and other doom commands
setx DOOMDIR %USERPROFILE%\emacs\doom-emacs\.doom.d
