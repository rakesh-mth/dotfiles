del %USERPROFILE%\.gitconfig
del %USERPROFILE%\.wslconfig
del %USERPROFILE%\emacs\spacemacs\.spacemacs.d\init.el
del %USERPROFILE%\emacs\doom-emacs\.doom.d\init.el
del %USERPROFILE%\emacs\doom-emacs\.doom.d\config.el
del %USERPROFILE%\emacs\doom-emacs\.doom.d\packages.el
del %USERPROFILE%\.vimrc
del %USERPROFILE%\AppData\Local\nvim\init.vim

mkdir %USERPROFILE%\AppData\Local\nvim
mkdir %USERPROFILE%\emacs\spacemacs\.spacemacs.d
mkdir %USERPROFILE%\emacs\doom-emacs\.doom.d

SCRIPTS=f:\DevTrees\scripts
DOTFILES=f:\DevTrees\rakesh-mth\dotfiles

mklink %USERPROFILE%\.gitconfig-work %SCRIPTS%\GIT\.gitconfig
mklink %USERPROFILE%\.gitconfig %DOTFILES%\GIT\.gitconfig
mklink %USERPROFILE%\.wslconfig %DOTFILES%\WSL\.wslconfig
mklink %USERPROFILE%\.vimrc %DOTFILES%\EDITORS\VIM\init.vim
mklink %USERPROFILE%\AppData\Local\nvim\init.vim %DOTFILES%\EDITORS\VIM\init.vim
REM chemacs - spacemacs and doom-emacs
mklink %USERPROFILE%\emacs\spacemacs\.spacemacs.d\init.el %DOTFILES%\EDITORS\EMACS\.spacemacs.d\.spacemacs
mklink %USERPROFILE%\emacs\doom-emacs\.doom.d\init.el %DOTFILES%\EDITORS\EMACS\.doom.d\init.el
mklink %USERPROFILE%\emacs\doom-emacs\.doom.d\config.el %DOTFILES%\EDITORS\EMACS\.doom.d\config.el
mklink %USERPROFILE%\emacs\doom-emacs\.doom.d\packages.el %DOTFILES%\EDITORS\EMACS\.doom.d\packages.el
REM set DOOMDIR env variable in current shell for `doom sync` and other doom commands
set DOOMDIR=%USERPROFILE%\emacs\doom-emacs\.doom.d
REM set DOOMDIR env variable permanently for `doom sync` and other doom commands
setx DOOMDIR %USERPROFILE%\emacs\doom-emacs\.doom.d
