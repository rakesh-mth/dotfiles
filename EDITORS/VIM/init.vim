" copy content of this file to ~/.config/nvim/init.vim on mac and linux when using neovim

" set commands : set default configs
    set showmatch           " Show matching brackets.
    set number              " Show the line numbers on the left side.
    set expandtab           " Insert spaces when TAB is pressed.
    set tabstop=4           " Render TABs using this many spaces.
    set shiftwidth=4        " Indentation amount for < and > commands.
    set path+=**            " search files in subfolders
    set relativenumber      " enable relative number, set rnu or set nornu, shortcuts
    set exrc                " load vimrc from current folder
    set secure              " disable shell, autocmd and write command when loading vimrc from local directory
    set foldmethod=indent   " fold method
    set foldnestmax=10      " fold settings
    set nofoldenable        " no fold on open a file
    set foldlevel=2         " fold level
    set ignorecase          " Make searching case insensitive
    set smartcase           " ... unless the query has capital letters.
    set gdefault            " Use 'g' flag by default with :s/foo/bar/.
    set splitbelow          " Horizontal split below current. -- More natural splits
    set splitright          " Vertical split to right of current. -- More natural splits
    set hlsearch            " search highlighting, not default in vim, default in neovim.
    set incsearch           " search while typing. `set is` or `set nois`. default in vim and neovim.
    set mouse=a             " enable mouse support (resize splits, etc...)
    " set cursorcolumn        " enable cursor column drawing
    if has('win32unix')
        set termguicolors   " enable true color
    else
        let colorterm=$COLORTERM
        if colorterm =~# 'truecolor' || colorterm =~# '24bit'
            set termguicolors       " enable true color
        endif
    endif
    set cursorline          " color the cursor line, highlight current line.
    set history=10000       " history of ex command. nvim default: 10000, vim default: 1000. keep is consistent to 10000.
    filetype plugin on
    syntax on
    let mapleader = "\<Space>" " map leader key to Space

" user home dir
    if has('win32') | let HOME_DIR = $USERPROFILE | else | let HOME_DIR = $HOME | endif
    let HOME_DIR = substitute(HOME_DIR, "\\", "\/", "g")
" vim and nvim folder
    if has('nvim') | let VIM_FOLDER = "nvim" | else | let VIM_FOLDER = "vim" | endif

" add python exe locations (virtualenvs)
    if has('win32') || has('win32unix')
        let python2_vp  = HOME_DIR . '/virtualenvs/python27/Scripts/python.exe'
        let python3_vp  = HOME_DIR . '/virtualenvs/python38/Scripts/python.exe'
        let python39_vp = HOME_DIR . '/virtualenvs/python39/Scripts/python.exe'
    elseif has('mac') || has('unix')
        let python2_vp  = HOME_DIR . '/.virtualenvs/python2.7/bin/python'
        let python3_vp  = HOME_DIR . '/.virtualenvs/python3.8/bin/python'
        let python39_vp = HOME_DIR . '/.virtualenvs/python3.9/bin/python'
    endif
    if !empty(glob(python2_vp))  | let g:python_host_prog = python2_vp   | endif
    if !empty(glob(python3_vp))  | let g:python3_host_prog = python3_vp  | endif
    if !empty(glob(python39_vp)) | let g:python3_host_prog = python39_vp | endif

" install plug.vim (bootstrap plugin)
    let plugRuntimePath = HOME_DIR . '/.config/' . VIM_FOLDER " internal uses only
    let plugPath = HOME_DIR . '/.config/' . VIM_FOLDER . '/autoload/plug.vim'
    if empty(glob(plugPath))
        silent execute '!curl -fLo ' . plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    let &rtp = &rtp . ',' . plugRuntimePath

" set viminfo for startify to work with vim
    if !has('nvim') && has('win32') | set viminfo+=n~/_viminfo | endif

" Plugins : add all plugins here
    function! Cond(cond, ...)
      let opts = get(a:000, 0, {})
      return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
    endfunction
    " Specify a directory for plugins
    call plug#begin('~/.config/' . VIM_FOLDER . '/plugged')

    " plugins that adds custom operator, following from - https://thoughtbot.com/upcase/videos/extending-the-vim-language
    Plug 'tpope/vim-surround' " adds cs{ change scope }, ds{ delete scope } and ys{ add scope } 
    Plug 'tpope/vim-commentary' " adds gc{motion}, gcc (comment a line)   
    Plug 'vim-scripts/ReplaceWithRegister' " adds ["reg]gr{motion}, ["reg]grr (replace a line from reg rgister)
    Plug 'tommcdo/vim-exchange' " adds cx{ motion }, cxx (fot line swap), and cxX (line swap in visual mode)
    Plug 'christoomey/vim-system-copy' 
    Plug 'christoomey/vim-sort-motion' 
    " plugin that adds custom text objects
    Plug 'kana/vim-textobj-user' " no text objects, used by other plugins
    Plug 'kana/vim-textobj-entire' " adds ae { entire_file } and ie { no_trailing_empty_lines } text object
    Plug 'kana/vim-textobj-indent' " ai, ii, aI, iI
    Plug 'kana/vim-textobj-line' " al, il
    " productivity plugins
    Plug 'arcticicestudio/nord-vim' " nord color scheme
    Plug 'trevordmiller/nova-vim' " nova color schema
    Plug 'morhetz/gruvbox' " grovebox color scheme
    Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only', Cond(has('nvim')) " solarized color scheme for neovim
    Plug 'altercation/vim-colors-solarized' " solarized color scheme. if not in gui then make sure terminal use solarized scheme.
    Plug 'vim-airline/vim-airline'
    Plug 'powerline/powerline-fonts'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf vim
    Plug 'junegunn/fzf.vim' " fzf vim extra (GFile, Buffers etc commands)
    Plug 'stsewd/fzf-checkout.vim' " Manage branches and tags with fzf. 
    Plug 'neomake/neomake', Cond(has('nvim'))
    Plug 'vim-syntastic/syntastic' " syntax checking
    Plug 'mhinz/vim-startify' " startup page
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'Yggdroot/indentLine' " add indent line
    Plug 'drmikehenry/vim-fontsize' " change font size using <leader><leader>+
    Plug 'szw/vim-tags' " auto generate tags using ctags, command TagsGenerate
    Plug 'soramugi/auto-ctags.vim' " auto generate tags using ctags, commands Ctags
    Plug 'airblade/vim-gitgutter' " git plugin to show changed lines 
    Plug 'arp242/auto_mkdir2.vim' " auto create directory during file save if directory does not exist
    Plug 'tpope/vim-fugitive' " git plugin that wraps git commands
    Plug 'tommcdo/vim-fubitive' " Extend fugitive.vim to support Bitbucket URLs in :Gbrowse
    Plug 'tpope/vim-dispatch' " background jobs. commands: :Make
    Plug 'jiangmiao/auto-pairs' " inserts quotes and parenthesis in pairs as you type
    Plug 'tpope/vim-unimpaired' " commonly used ex commands, ]q [q ]Q [Q etc...
    Plug 'tpope/vim-sensible' " some defaults agreed
    Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands that need it the most. Mkdir!
    Plug 'godlygeek/tabular' " Tabular for aligning texts in tabular format
    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    if has('win32unix')
    else
        Plug 'SirVer/ultisnips' " Track the engine. for snippets.
        if !has('nvim-0.5')
            " Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' } " code completion
            Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode. complete with YouCompleteMe
        endif
    endif
    if has('nvim-0.5')
        Plug 'neovim/nvim-lspconfig'
        Plug 'nvim-lua/completion-nvim'
    endif
    Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
    " Code to execute when the plugin is lazily loaded on demand
    Plug 'junegunn/goyo.vim' " , { 'for': 'markdown' }
    Plug 'junegunn/limelight.vim' " limelight used with goyo (see autocmd)
    " language support
    Plug 'kevinoid/vim-jsonc' " vim syntax highlight plugin for json with c-style (// and /**/) comments
    Plug 'PProvost/vim-ps1' " powershell syntax coloring
    Plug 'rust-lang/rust.vim' " rust language support
    Plug 'fatih/vim-go' " , { 'do': ':GoUpdateBinaries' } " golang support
    Plug 'HerringtonDarkholme/yats.vim' " Add a syntax file for typescript. YATS is the best
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'} " typescript support
    Plug 'sheerun/vim-polyglot' " used by nova color schema, multiple programming language support (basic)
    Plug 'mattn/webapi-vim' " webapi neede by rust pluggin
    Plug 'rhysd/vim-healthcheck', Cond(has('nvim'))

    " Initialize plugin system
    call plug#end()

" lsp config for nvim version > 0.5
if has('nvim-0.5')
lua <<EOF
require'lspconfig'.gopls.setup{}
require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
EOF
endif

" configure option (string, number, list) and env variables
    if has('win32')
        let $PATH='C:\Program Files\Git\bin;'.$PATH " add git-bash in the path for fzf + bat to work correctly
        let &cdpath='f:\DevTrees,,' " cdpath to easily change directory using lcd (lcd foldername-in-cdpath)
    elseif has('macunix') || ('unix')
        let &cdpath=$HOME.'/workspaces,,'
    endif

" lsp for omni func complition
    " autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

" toggle gui elements in VIM (no impact in nvim-qt)
    function! ToggleGUICruft()
      if &guioptions==''
        exec('set guioptions=imTr')
      else
        exec('set guioptions-=imTr')
      endif
    endfunction

" use nord colorscheme
    set background=dark " light or dark
    colorscheme gruvbox
    if has('nvim')
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        " colorscheme solarized_nvimqt
    else
        if has('win32')
            set directory=~\AppData\Local\Temp
            set backupdir=~\AppData\Local\Temp
            set undodir=~\AppData\Local\Temp
        else
            set directory=~/temp
            set backupdir=~/temp
            set undodir=~/temp
        endif
        if has('gui_running')
            " colorscheme solarized
            set guioptions=imTr
            set guioptions-=imTr  "no_icon, menu_bar, toolbar, scrollbar
            nnoremap <F11> <Esc>:call ToggleGUICruft()<cr>
        else
            " colorscheme nord 
        endif
    endif

" spell checker
    map <leader>sp :setlocal spell! spelllang=en_us<cr>

" disable highlights
    nnoremap <leader>nh :noh<cr>    

" set font - nvim -> source code pro font, FVIM -> Hack
    if exists('g:fvim_loaded')
        set guifont=Hack:h24
    else
        set guifont=Source\ Code\ Pro\ for\ Powerline:h20:cANSI
        " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h16:cANSI
    endif

" productivity
    nnoremap <leader>] ]]zz
    nnoremap <leader>[ [[zz
    nnoremap <leader>lu mqO<Esc>`q| " add a line above 
    nnoremap <leader>ld mqo<Esc>`q| " add a line below
    nnoremap <leader>cc <Esc>6i#<Esc>A| " add 6 # and place cursor at the end (comment begin)
    nnoremap <leader>vs :exe ':silent !code %'<CR>:redraw!<CR>
    " Ctrl-ScrollWheel for zooming in/out
    if exists('g:fvim_loaded') " fvim related
        nnoremap <silent> <C-ScrollWheelUp>   :set guifont=+<CR>
        nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
        nnoremap <silent> <C-=> :set guifont=+<CR>
        nnoremap <silent> <C--> :set guifont=-<CR>
        nnoremap <A-CR> :FVimToggleFullScreen<CR>
    else 
        function! ZoomGuiFont(direction)
            let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1*a:direction)', 'g')
        endfunc
        nnoremap <silent> <C-ScrollWheelUp>   :silent! call ZoomGuiFont(1)<CR>
        nnoremap <silent> <C-ScrollWheelDown> :silent! call ZoomGuiFont(-1)<CR>
        nnoremap <silent> <C-=> :silent! call ZoomGuiFont(1)<CR>
        nnoremap <silent> <C--> :silent! call ZoomGuiFont(-1)<CR>
    endif
    if has('nvim')
        let s:fullScreen = 0
        function! NVimToggleFullScreen()
            if exists('g:GuiLoaded')
              if(s:fullScreen == 1)
                let s:fullScreen = 0
              else
                let s:fullScreen = 1
              endif
              call GuiWindowFullScreen(s:fullScreen)
            endif
        endfunc
        if !exists('g:fvim_loaded')
            nnoremap <A-CR> :call NVimToggleFullScreen()<CR>
        endif
        inoremap <silent>  <S-Insert>  <C-R>+| "paste from system clipboard in insert mode
    endif

" quickfix mappings
    nnoremap <leader>qo :copen<cr>
    nnoremap <leader>qc :ccl<cr>
    nnoremap <leader>qn :cnext<cr>
    nnoremap <leader>qp :cprev<cr>

" spacemacs key bindings
    " Toggle buffer
    let s:bufferState = 0
    function! BufferToggle()
      if(s:bufferState == 1)
        let s:bufferState = 0
        bp
      else
        let s:bufferState = 1
        bn
      endif
    endfunc
    nnoremap <leader><TAB> :call BufferToggle()<cr>| " Toggle between presious and current buffer.
    nnoremap <leader><leader> :| " switch to command mode
    nnoremap <leader>fed :e $MYVIMRC<cr>| " open vim configuration file (.vimrc or init.vim)
    nnoremap <leader>gb  :GBranches<cr>| " open  page (from fugitive)
    nnoremap <leader>gt  :GTags<cr>| " open  page (from fugitive)
    nnoremap <leader>gs  :Gstatus<cr>| " open git status page (from fugitive)
    nnoremap <leader>gd :tabe \| Git diff \| wincmd o<cr>| " open git diff in new tab
    nnoremap <leader>gdd :tabe \| Git diff --staged \| wincmd o<cr>| " open git diff in new tab
    " Toggle cursor column
    function! ToggleCursorCol() abort
      if &cursorcolumn
        set nocursorcolumn
        echo 'cursorcolumn: OFF'
      else
        set cursorcolumn
        echo 'cursorcolumn: ON'
      endif
    endfunction
    " toggle relativenumber
    function! ToggleRelativeNumber() abort
      if &relativenumber
        set relativenumber!
        echo 'relativenumber: OFF'
      else
        set relativenumber
        echo 'relativenumber: ON'
      endif
    endfunction
    nnoremap <leader>tc :call ToggleCursorCol()<cr>| " toggle cursor column
    nnoremap <leader>tr :call ToggleRelativeNumber()<cr>| " toggle cursor column

" keybindig for goyo
    nnoremap <leader>go :Goyo<cr>

" terminals : map esc key to switch to normal mode from terminal mode
    tnoremap <Esc> <C-\><C-n>
    for idx in range( 1, 9 )
        execute 'tnoremap <M-' . idx . '> <C-\><C-n>' . idx . 'gt'
    endfor
    for alph in ['w', 'h', 'j', 'k', 'l']
        execute 'tnoremap <C-w>' . alph . ' <C-\><C-n><C-w>' . alph
    endfor
    tnoremap <C-w><C-w> <C-\><C-n><C-w>w

" windows : maximize window (virtually split only)
    nmap <leader>mm <C-w>1000>
    nmap <leader>mn <C-w>1000<

" tabs : change tabs using \tn1, \tn2, \tn3..., and Alt-1, Alt-2, Alt-3...
    function! AltMapping()
        nnoremap <M-0> 10gt
        for idx in range( 1, 9 )
            execute 'nnoremap <M-' . idx . '> ' . '<C-[>' . idx . 'gt'
        endfor
    endfunction
    nnoremap <silent> <leader>tn :exe "tabn" nr2char(getchar())<cr>

" for plugin vim-tags and auto-ctags - auto generate tags on file saving. using vim-tags by defualt.
    let g:auto_ctags = 0
    let g:auto_ctags_directory_list = ['.git', '.svn']
    let g:auto_ctags_tags_args = ['--tag-relative=yes', '--recurse=yes', '--sort=yes', '--exclude=layout', '--exclude=outputs', '--exclude=sdk']
    let g:vim_tags_auto_generate = 0
    let g:vim_tags_directories = ['.git', '.hg', '.svn', '.bzr', '_darcs', 'CVS']
    let g:vim_tags_ignore_files = []
    let g:vim_tags_project_tags_command = "fd -e cpp -e h -e json -e yml -e txt | ctags -f .git/tags --tag-relative=yes --extra=+f -L - "
    " let g:vim_tags_use_vim_dispatch = 1

" set tags path inside .git folder
    set tags=./tags,.git/tags
    nnoremap <leader>ta :tag 

" for IndentLine plugin
    let g:indentLine_enabled = 1
    let g:indentLine_showFirstIndentLevel = 1
    let g:indentLine_leadingSpaceEnabled = 1
    nnoremap <silent> <leader>ie :IndentLinesEnable<CR> :LeadingSpaceEnable<CR> 
    nnoremap <silent> <leader>id :IndentLinesDisable<CR> :LeadingSpaceDisable<CR> 

" for plugin vim-cpp-enhanced-highlight
    let g:cpp_class_scope_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_experimental_simple_template_highlight = 1
    let g:cpp_member_variable_highlight = 1

" for plugin nerd tree : enable line numbers, make sure relative line numbers are used
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1
    let NERDTreeShowLineNumbers=1
    nnoremap <silent> <leader>pt :NERDTreeToggle<Enter> :normal zz<CR> :wincmd p<CR>
    nnoremap <silent> <leader>ptf :NERDTreeFind<CR> :normal zz<CR> :wincmd p<CR>

" for plugin ultisnips : Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

" startify configurations
    if has('win32')
        let g:startify_bookmarks = ['f:\DevTrees']
    elseif has('macunix') || ('unix')
        let g:startify_bookmarks = ['~/workspaces/']
    endif

" for plugin fzf
    noremap <leader>pf :GFiles<CR>
    noremap <leader>pF :Files<CR>
    noremap <leader>bb :Buffers<CR>
    noremap <leader>w :Windows<CR>
    noremap <leader>l :BLines<CR>
    noremap <leader>L :Lines<CR>
    noremap <leader>c :Colors<CR>
    " Insert mode completion, fails on windows when it looks for /usr/share/dict/words.
    if has('macunix') || ('unix')
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)
    endif
    " Open files in vertical horizontal split
    nnoremap <silent> <Leader>pfS :call fzf#run(fzf#wrap( { 'sink': 'botright split', 'down': '40%' } ))<CR>
    nnoremap <silent> <Leader>pfs :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink': 'botright split', 'down': '40%' } ))<CR>
    " Open files in horizontal split
    nnoremap <silent> <Leader>pfV :call fzf#run(fzf#wrap( { 'sink':  'vertical botright split', 'right': winwidth('.') / 2 } ))<CR>
    nnoremap <silent> <Leader>pfv :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink':  'vertical botright split', 'right': winwidth('.') / 2 } ))<CR>
    " Open files in another tab
    nnoremap <silent> <Leader>pfT :call fzf#run(fzf#wrap( { 'sink':  'tabedit', 'window': 'botright 50vnew' } ))<CR>
    nnoremap <silent> <Leader>pft :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink':  'tabedit', 'window': 'botright 50vnew' } ))<CR>
    " Locate every file on the system
    command! -nargs=1 -bang Locate call fzf#run(fzf#wrap({'source': 'locate <q-args>', 'options': '-m'}, <bang>0))
    " An action can be a reference to a function that processes selected lines
    function! s:build_quickfix_list(lines)
      call setqflist(map(copy(a:lines), '{ "filename": v:val }')) | copen | cc
    endfunction
    " change fzf action to use ctrl-s instead of ctrl-x for horizontal split
    let g:fzf_action = { 'ctrl-c': function('s:build_quickfix_list'), 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
    " change select-all from A-a to C-a. now can use C-a C-c to bring back all results to quickfix window
    let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" move files from copen to args from https://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim
    command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
    function! QuickfixFilenames()
      " Building a hash ensures we get each buffer only once
      let buffer_numbers = {}
      for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
      endfor
      return join(values(buffer_numbers))
    endfunction

" Toggle relative numbering
    function! NumberToggle()
      if(&relativenumber == 1)
        set nornu
      else
        set rnu
      endif
    endfunc
    nnoremap <silent> <leader>r :call NumberToggle()<cr>| " Toggle between normal and relative numbering.

" Toggle header and cpp file
    function! SwitchSourceHeader()
        if (expand("%:e") == "cpp" || expand("%:e") == "c")
            execute 'tag ' . expand("%:t:r") . '.h'
        elseif (expand("%:e") == "h")
            execute 'tag ' . expand("%:t:r") . '.cpp'
        else
            echo "file in not either .h, .c or .cpp"
        endif
    endfunction
    nnoremap <silent> <leader>o :call SwitchSourceHeader()<CR>

" delete inactive buffers
    function! DeleteInactiveBufs()
        "From tabpagebuflist() help, get a list of all buffers in all tabs
        let tablist = []
        for i in range(tabpagenr('$'))
            call extend(tablist, tabpagebuflist(i + 1))
        endfor

        let nWipeouts = 0
        for i in range(1, bufnr('$'))
            if bufexists(i) && !getbufvar(i,"&mod") && getbufvar(i, "&buftype") != "terminal" && index(tablist, i) == -1
           		"bufno exists AND isn't modified AND isn't terminal buffer AND isn't in the list of buffers open in windows and tabs
                silent exec 'bwipeout' i
                let nWipeouts = nWipeouts + 1
            endif
        endfor
        echomsg nWipeouts . ' buffer(s) wiped out'
    endfunction
    command! Bdi :call DeleteInactiveBufs()
    nnoremap <silent> <leader>bd :call DeleteInactiveBufs()<CR>

" refresh buffers if files changed outside vim 
    " Like bufdo but restore the current buffer.
    function! BufDo(command)
        let currBuff=bufnr("%")
        execute 'bufdo ' . a:command 
        execute 'buffer ' . currBuff 
    endfunction
    command! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
    noremap <leader>br :Bufdo e<cr><esc>

" add line above and below without leaving normal mode
    nnoremap <silent> <leader>ad :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nnoremap <silent> <leader>au :set paste<CR>m`O<Esc>``:set nopaste<CR>

" copy and paste from system clipboard using \y and \p
    nnoremap <leader><C-y> "*y
    nnoremap <leader><C-p> "*p
    nnoremap <leader>y "+y
    nnoremap <leader>p "+p
    nnoremap <leader>Y "+Y
    nnoremap <leader>P "+P
    nnoremap <leader>yy "+yy

" update args with git listed files
    noremap <leader>a :args `git ls-files`<cr> 2<C-o>

" search TODO, FIXME or any text and put them in cwindow
    function! AgCommand(word, options)
        if !executable('ag')
            return s:warn('ag is not found, please install the_silver_searcher')
        endif
        cexpr system("ag --nogroup --column --vimgrep " . a:options . " " . a:word)
    endfunc
    function! RgCommand(word, options)
        if !executable('rg')
            return s:warn('rg is not found, please install ripgrep')
        endif
        cexpr system("rg --column --line-number --vimgrep " . a:options . " " . a:word)
    endfunc
    nnoremap <leader>stc  :silent vimgrep /TODO\\|FIXME/j % \| :cw<CR>
    nnoremap <leader>sta  :silent vimgrep /TODO\\|FIXME/j `git ls-files` \| :cw<CR>
    nnoremap <leader>sav  :execute 'silent vim! <cword> `git ls-files` \| copen \| cc'<cr>
    nnoremap <leader>saai :call AgCommand(expand("<cword>"), "--ignore-case")<cr>
    nnoremap <leader>saas :call AgCommand(expand("<cword>"), "--case-sensitive")<cr>
    nnoremap <leader>sari :call RgCommand(expand("<cword>"), "--ignore-case")<cr>
    nnoremap <leader>sars :call RgCommand(expand("<cword>"), "--case-sensitive")<cr>
    nnoremap <leader>sa   :call RgCommand(expand("<cword>"), "--case-sensitive")<cr>
    " nnoremap <leader>sa   :execute 'normal <leader>sars'<cr>
    nnoremap <leader>*    :Rg <C-R><C-W><CR>
    nnoremap <leader>#    :Ag <C-R><C-W><CR>
    nnoremap <leader>/    :Rg 
    nnoremap <leader>\t  /\|.\{-}\|<cr>| "search tags in vim help documents
    command! -nargs=+ VimCpp execute 'silent vim! <args> **/*.cpp **/*.c **/*.h' | copen | cc
    command! -nargs=+ VimH execute 'silent vim! <args> **/*.h' | copen | cc
    command! -nargs=+ Vim execute 'silent vim! <args> `git ls-files`' | copen | cc

" search and replace 
    nnoremap <leader>rc  :%s/\<<C-r>=expand("<cword>")<CR>\>/
    nnoremap <leader>raai :call AgCommand(expand("<cword>"), "-i")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>raas :call AgCommand(expand("<cword>"), "-s")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>rari :call RgCommand(expand("<cword>"), "-i")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>rars :call RgCommand(expand("<cword>"), "-s")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>ra   :call RgCommand(expand("<cword>"), "-s")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    " nnoremap <leader>ra   :execute 'normal <leader>rars'<cr>
    nnoremap <leader>rav :Vim <cword><cr> :cfdo %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>rad :argdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>rcd :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>

" use nvr to avoid nested nvim when using git commit in a terminal buffer
    if has('nvim')
        let $GIT_EDITOR = 'nvr -cc split --remote-wait'
        " delete git commit buffer after :wq, git waits for nvr to finish
        augroup git_commit
            autocmd! FileType gitcommit,gitrebase set bufhidden=delete
        augroup END
    endif

" open terminal with splits (also git bash prompt)
    if has('win32')
        if has('nvim')
            let curWindow = ""
            let insertMode = "i"
        else
            let curWindow = "\+\+curwin"
            let insertMode = ""
        endif
        execute 'nnoremap <silent> <leader>asg  :new  \| term ' . curWindow . ' "c:\program files\Git\bin\bash.exe"<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asgv :vnew \| term ' . curWindow . ' "c:\program files\Git\bin\bash.exe"<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asgt :tabe \| term ' . curWindow . ' "c:\program files\Git\bin\bash.exe"<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asb  :new  \| term ' . curWindow . ' C:\Windows\System32\bash.exe<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asbv :vnew \| term ' . curWindow . ' C:\Windows\System32\bash.exe<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asbt :tabe \| term ' . curWindow . ' C:\Windows\System32\bash.exe<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asp  :new  \| term ' . curWindow . ' powershell<cr>' . insertMode
        execute 'nnoremap <silent> <leader>aspv :vnew \| term ' . curWindow . ' powershell<cr>' . insertMode
        execute 'nnoremap <silent> <leader>aspt :tabe \| term ' . curWindow . ' powershell<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asc  :new  \| term ' . curWindow . ' cmd<cr>' . insertMode
        execute 'nnoremap <silent> <leader>ascv :vnew \| term ' . curWindow . ' cmd<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asct :tabe \| term ' . curWindow . ' cmd<cr>' . insertMode
        unlet curWindow insertMode
        nmap <leader>' <leader>asg
        nmap <leader><leader>' <leader>asgv
        nmap <leader><leader><leader>' <leader>asgt
        nmap <leader>" <leader>asc
        nmap <leader><leader>" <leader>ascv
        nmap <leader><leader><leader>" <leader>asct
    else
        nnoremap <silent> <leader>ascs :sp \| term<cr><insert>
        nnoremap <silent> <leader>ascv :vs \| term<cr><insert>
        nnoremap <silent> <leader>asct :tabe \| term<cr><insert>
        nnoremap <silent> <leader>asbs :sp \| term /bin/bash<cr><insert>
        nnoremap <silent> <leader>asbv :vs \| term /bin/bash<cr><insert>
        nnoremap <silent> <leader>asbt :tabe \| term /bin/bash<cr><insert>
        nmap <leader>' <leader>ascs
        nmap <leader><leader>' <leader>ascv
        nmap <leader><leader><leader>' <leader>asct
        nmap <leader>" <leader>asbs 
        nmap <leader><leader>" <leader>asbv
        nmap <leader><leader><leader>" <leader>asbt
    endif

" auto commands on events
    " auto switch to insert mode when terminal buffer becomes active
    augroup auto_term_insert_and_do_not_close_on_last_window_exit
        autocmd!
        autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif
        " autocmd BufCreate,BufWinEnter,WinEnter term://* startinsert
        if has('nvim')
            autocmd TermOpen * set bufhidden=hide " hide buffer so that switching out of terminal window does not close terminal
            autocmd TermClose * bd! | if winnr('$') == 0 | tabprevious | endif " switch to previous tab if there are no more window
        endif
    augroup END 

    " auto source vimrc after writing new changes
    augroup source_vimrc
        autocmd! BufWritePost $MYVIMRC source $MYVIMRC
    augroup END

    " auto open cwindow (copen) after search using vimgrep(or vim)
    augroup qf_auto_open_on_vimgrep
        autocmd!
        autocmd QuickFixCmdPost [^l]* cwindow
        autocmd QuickFixCmdPost l*    cwindow
        " autocmd VimEnter        *     cwindow
    augroup END

    " returns true if NERDTree open/active
    function! s:IsNerdTreeOpen() 
      return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
    endfunction
    augroup plugin_nerd_tree
        autocmd FileType nerdtree setlocal relativenumber
        autocmd BufEnter *.cpp,*.h,*.py,*.sh,*.yml,*.bat,*.md,*.json,*.txt if &modifiable && s:IsNerdTreeOpen() && strlen(expand('%')) > 0 && !&diff | NERDTreeFind | wincmd p | endif
    augroup END 

    augroup plugin_goyo
        autocmd!    
        autocmd! User goyo.vim echom 'Goyo is now loaded!'
        autocmd! User GoyoEnter Limelight
        autocmd! User GoyoLeave Limelight!
    augroup END

    function! VimEnterFunction()
        call AltMapping()
    endfun
    augroup VimEnterGroup
        autocmd!
        autocmd VimEnter * call VimEnterFunction()
    augroup END

" build rfwin projects
    noremap <leader>mrg :Dispatch ctxmake gfxrender<CR>
    noremap <leader>brg :!msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender /p:Configuration=Release /p:Platform=win32<CR>
    noremap <leader>brgd :Dispatch! msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender /p:Configuration=Release /p:Platform=win32<CR>
    noremap <leader>brt :!msbuild CitrixReceiver\WFCAll.sln  /t:src\drivers\vd\vdtw\vdtw30n /p:Configuration=Release /p:Platform=win32<CR>
    noremap <leader>brtd :Dispatch! msbuild CitrixReceiver\WFCAll.sln  /t:src\drivers\vd\vdtw\vdtw30n /p:Configuration=Release /p:Platform=win32<CR> 
    noremap <leader>bta :!msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender;src\pal\gfxvisualization;src\drivers\vd\vdtw\vdtw30n;src\drivers\vd\vdlfp /p:Configuration=Release /p:Platform=win32<CR>


" source plug configs
    let COC_VIM_PATH = HOME_DIR . "/.config/nvim/plug-config/coc/coc.vim"
    let COC_EXTENSIONS_PATH = HOME_DIR . "/.config/nvim/plug-config/coc/coc-extensions.vim"
    if filereadable(COC_VIM_PATH) | exec "source " . COC_VIM_PATH | endif
    if filereadable(COC_EXTENSIONS_PATH) | exec "source " . COC_EXTENSIONS_PATH | endif

