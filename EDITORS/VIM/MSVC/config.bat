if not exist "%USERPROFILE%"\AppData\Local\nvim mkdir "%USERPROFILE%"\AppData\Local\nvim

SET DOTFILES=f:\DevTrees\rakesh-mth\dotfiles
mkdir %USERPROFILE%"\AppData\Local\nvim\lua


if exist "%USERPROFILE%"\AppData\Local\nvim\init.vim del "%USERPROFILE%"\AppData\Local\nvim\init.vim
if exist "%USERPROFILE%"\AppData\Local\nvim\init.lua del "%USERPROFILE%"\AppData\Local\nvim\init.lua

mklink "%USERPROFILE%"\AppData\Local\nvim\init.lua %DOTFILES%\EDITORS\VIM\MSVC\init.lua
mklink /D "%USERPROFILE%"\AppData\Local\nvim\lua\plugins %DOTFILES%\EDITORS\VIM\MSVC\plugins
