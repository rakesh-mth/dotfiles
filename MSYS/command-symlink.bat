SET HOMEDIR=F:\msys64\home\RakeshKumar

@REM create .config dir
mkdir %HOMEDIR%\workspaces
mkdir %HOMEDIR%\.config
mkdir %HOMEDIR%\.config\nvim
mkdir %HOMEDIR%\.config\nvim-data

@REM BASH
mklink %HOMEDIR%\.bashrc F:\DevTrees\rakesh-mth\dotfiles\MSYS\BASH\.bashrc


@REM GIT
mklink %HOMEDIR%\.gitconfig F:\DevTrees\rakesh-mth\dotfiles\MSYS\GIT\.gitconfig
mklink %HOMEDIR%\.gitconfig-orig F:\DevTrees\rakesh-mth\dotfiles\GIT\.gitconfig
mklink %HOMEDIR%\.gitconfig-work F:\DevTrees\scripts\GIT\.gitconfig


@REM neovim
@REM vim-plug pluggin. iwr is a powershell command
@REM mklink %HOMEDIR%\.config\nvim\init.vim F:\DevTrees\rakesh-mth\dotfiles\EDITORS\VIM\MSYS2\init.vim
@REM iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
@REM packer plugin - install is not needed as this is done from the init.lua
@REM git clone --depth 1 https://github.com/wbthomason/packer.nvim %HOMEDIR%/.config/nvim-data/site/pack/packer/start/packer.nvim
mklink %HOMEDIR%\.config\nvim\init.lua F:\DevTrees\rakesh-mth\dotfiles\EDITORS\VIM\MSYS2\init.lua


@REM all other scripts
mklink /D %HOMEDIR%\scripts F:\DevTrees\rakesh-mth\dotfiles\MSYS\SCRIPTS
@REM dotfiles symlink
mklink /D %HOMEDIR%\workspaces\dotfiles F:\DevTrees\rakesh-mth\dotfiles