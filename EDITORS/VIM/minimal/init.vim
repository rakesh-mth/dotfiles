set nocompatible
filetype plugin indent on
set number
set relativenumber
set path+=**
set wildmenu

if !has("gui_running")
    set t_Co=256
endif

set tabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces

" netrw specific
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3 " preferred view type
let g:netrw_browse_split = 4 " changing how the files are opened, use previous window
let g:netrw_altv=1
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

nnoremap <Space>p :Vex<CR>
