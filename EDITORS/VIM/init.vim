" this file can be used as .vimrc or init.vim on windows, linux and mac
" works with neovim-qt, gvim (windows), fvim (windows), vimr (mac), macvim (mac)
 
" user home dir
    if has('win32') | let HOME_DIR = $USERPROFILE | else | let HOME_DIR = $HOME | endif
    let HOME_DIR = substitute(HOME_DIR, "\\", "\/", "g")
" vim and nvim folder
    if has('nvim') | let VIM_FOLDER = "nvim" | else | let VIM_FOLDER = "vim" | endif
" plugged folder
    let PLUGGED_DIR = HOME_DIR . '/.config/' . VIM_FOLDER . '/plugged' " Specify a directory for plugins 

" install plug.vim (bootstrap plugin)
    let plugRuntimePath = HOME_DIR . '/.config/' . VIM_FOLDER " internal uses only
    let plugPath = plugRuntimePath . '/autoload/plug.vim'
    if empty(glob(plugPath))
        silent execute '!curl -fLo ' . plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    let &rtp = &rtp . ',' . plugRuntimePath

" auto install all plugin if vim-user-config is missing (bootstrap vim-user-config). 
    let VIM_USER_CONFIG_PLUGIN = PLUGGED_DIR . '/vim-user-config/core/plugins.vim'
    if !filereadable(VIM_USER_CONFIG_PLUGIN)
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" Plugins : add all plugins here
    call plug#begin(PLUGGED_DIR)
        Plug 'rakesh-mth/vim-user-config' 
        if filereadable(VIM_USER_CONFIG_PLUGIN) | exec 'source ' . VIM_USER_CONFIG_PLUGIN | endif
    call plug#end()

