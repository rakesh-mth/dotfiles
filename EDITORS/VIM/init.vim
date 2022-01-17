" this file can be used as .vimrc or init.vim on windows, linux and mac
" works with neovim-qt, gvim (windows), fvim (windows), vimr (mac), macvim (mac)
 
" user home dir
    if has('win32') | let g:UC_HOME_DIR = $USERPROFILE | else | let g:UC_HOME_DIR = $HOME | endif
    let g:UC_HOME_DIR = substitute(g:UC_HOME_DIR, "\\", "\/", "g")
" vim and nvim folder
    if has('nvim') | let g:UC_VIM_FOLDER = "nvim-config/rakesh-mth" | else | let g:UC_VIM_FOLDER = "vim-config/rakesh-mth" | endif
" vim folder full path
    let g:UC_VIM_CONFIG_FOLDER_FULL_PATH = g:UC_HOME_DIR . '/.config/' . g:UC_VIM_FOLDER
" plugged folder
    let g:UC_PLUGGED_DIR = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/plugged' " Specify a directory for plugins 
" workspace folder
    let g:UC_WORKSPACE_FOLDER= has('win32') ? 'f:\DevTrees' : $HOME . '/workspaces'

" install plug.vim (bootstrap plugin)
    let plugPath = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/autoload/plug.vim'
    if empty(glob(plugPath))
        silent execute '!curl -fLo ' . plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" remove default config path on windows from rtp list, not needed now after setup callback in cheovim
    " if has('win32')
    "     set runtimepath-=~\AppData\Local\nvim
    " endif

" add path of rakesh-mth to rtp 
    let &rtp = &rtp . ',' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH

" plugin settings
    let g:airline_powerline_fonts = 1 " enable powerline font in airline status plugin

" auto install all plugin if vim-user-config is missing (bootstrap vim-user-config). 
    let VIM_USER_CONFIG_PLUGIN = g:UC_PLUGGED_DIR . '/vim-user-config/core/plugins.vim'
    if !filereadable(VIM_USER_CONFIG_PLUGIN)
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" Plugins : add all plugins here
    call plug#begin(g:UC_PLUGGED_DIR)
        " install vim-user-config plugin for plugin.vim from vim-user-config
        if !filereadable(VIM_USER_CONFIG_PLUGIN) | Plug 'rakesh-mth/vim-user-config' | endif
        if filereadable(VIM_USER_CONFIG_PLUGIN)  | exec 'source ' . VIM_USER_CONFIG_PLUGIN | endif
        " include vim-user-config towards end so that all other plugin are
        " loaded by now. except in the case when there are no plugin
        " installed, and in that case it is included before all.
        Plug 'rakesh-mth/vim-user-config' 
    call plug#end()

