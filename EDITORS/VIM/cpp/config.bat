if not exist "%USERPROFILE%"\AppData\Local\nvim mkdir "%USERPROFILE%"\AppData\Local\nvim

SET DOTFILES=f:\DevTrees\rakesh-mth\dotfiles

mklink "%USERPROFILE%"\AppData\Local\nvim\init.vim %DOTFILES%\EDITORS\VIM\cpp\init.vim
