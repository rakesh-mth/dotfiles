" copy content of this file to ~/.config/nvim/init.vim on mac and linux when using neovim

" user home dir
    if has('win32') | let HOME_DIR = $USERPROFILE | else | let HOME_DIR = $HOME | endif
    let HOME_DIR = substitute(HOME_DIR, "\\", "\/", "g")
" vim and nvim folder
    if has('nvim') | let VIM_FOLDER = "nvim" | else | let VIM_FOLDER = "vim" | endif
" workspace folder
    let PLUGGED_DIR = HOME_DIR . '/.config/' . VIM_FOLDER . '/plugged'

" install plug.vim (bootstrap plugin)
    let plugRuntimePath = HOME_DIR . '/.config/' . VIM_FOLDER " internal uses only
    let plugPath = HOME_DIR . '/.config/' . VIM_FOLDER . '/autoload/plug.vim'
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

" Plugins : add all plugins here, Specify a directory for plugins
    call plug#begin(PLUGGED_DIR)
        Plug 'rakesh-mth/vim-user-config' 
        if filereadable(VIM_USER_CONFIG_PLUGIN) | exec 'source ' . VIM_USER_CONFIG_PLUGIN | endif
    call plug#end()

