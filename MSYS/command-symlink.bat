SET HOMEDIR=F:\msys64\home\RakeshKumar

@REM BASH
mklink %HOMEDIR%\.bashrc F:\DevTrees\rakesh-mth\dotfiles\MSYS\BASH\.bashrc


@REM GIT
mklink %HOMEDIR%\.gitconfig F:\DevTrees\rakesh-mth\dotfiles\MSYS\GIT\.gitconfig
mklink %HOMEDIR%\.gitconfig-orig F:\DevTrees\rakesh-mth\dotfiles\GIT\.gitconfig
mklink %HOMEDIR%\.gitconfig-work F:\DevTrees\scripts\GIT\.gitconfig


@REM neovim
mklink %HOMEDIR%\.config\nvim\init.vim F:\DevTrees\rakesh-mth\dotfiles\EDITORS\VIM\MSYS2\init.vim


@REM all other scripts
mklink /D %HOMEDIR%\scripts F:\DevTrees\rakesh-mth\dotfiles\MSYS\SCRIPTS

mkdir %HOMEDIR%\workspaces
mklink /D %HOMEDIR%\workspaces\dotfiles F:\DevTrees\rakesh-mth\dotfiles