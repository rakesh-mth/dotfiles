" copy content of this file to ~/.config/nvim/init.vim on mac and linux when using newovim

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
    if has('win32unix')
    else
        set termguicolors       " enable true color
    endif
    set cursorline          " color the cursor line, highlight current line.
    set history=10000       " history of ex command. nvim default: 10000, vim default: 1000. keep is consistent to 10000.
    filetype plugin on
    syntax on
    let mapleader = "\<Space>" " map leader key to Space

" add python exe locations (virtualenvs)
    if has('win32')
        let python2_vp = '$USERPROFILE\virtualenvs\python27\Scripts\python.exe'
        let python3_vp = '$USERPROFILE\virtualenvs\python38\Scripts\python.exe'
        if !empty(glob(python2_vp)) | let g:python_host_prog = python2_vp | endif
        if !empty(glob(python3_vp)) | let g:python3_host_prog = python3_vp | endif
    endif

" install plug.vim (bootstrap plugin)
    if has('macunix') || has('unix')
        if has('nvim')
            let plugPath = '~/.config/nvim/autoload/plug.vim'
            let plugPathSearch = plugPath 
        else
            let plugPath = '~/.vim/autoload/plug.vim'
            let plugPathSearch = plugPath 
        endif
    elseif has('win32')
        if has('nvim')
            let plugPath = '\%USERPROFILE\%\AppData\Local\nvim\autoload\plug.vim'
            let plugPathSearch = '$USERPROFILE\AppData\Local\nvim\autoload\plug.vim'
        else
            let plugPath = '\%USERPROFILE\%\vimfiles\autoload\plug.vim'
            let plugPathSearch = '$USERPROFILE\vimfiles\autoload\plug.vim'
        endif
    endif
    if empty(glob(plugPathSearch))
        silent execute '!curl -fLo ' . plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    unlet plugPathSearch plugPath

" Plugins : add all plugins here
    function! Cond(cond, ...)
      let opts = get(a:000, 0, {})
      return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
    endfunction
    " Specify a directory for plugins
    if has('nvim')
        call plug#begin('~/.nvim/plugged')
    else
        call plug#begin('~/.vim/plugged') 
    endif
    " set viminfo for startify to work with vim
    if !has('nvim') && has('win32') | set viminfo+=n~/_viminfo | endif

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
    Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only' " solarized color scheme for neovim
    Plug 'altercation/vim-colors-solarized' " solarized color scheme. if not in gui then make sure terminal use solarized scheme.
    Plug 'vim-airline/vim-airline'
    Plug 'powerline/powerline-fonts'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf vim
    Plug 'junegunn/fzf.vim' " fzf vim extra (GFile, Buffers etc commands)
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
    Plug 'tpope/vim-dispatch' " background jobs. commands: :Make
    Plug 'tpope/vim-unimpaired' " commonly used ex commands, ]q [q ]Q [Q etc...
    Plug 'tpope/vim-sensible' " some defaults agreed
    Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands that need it the most. Mkdir!
    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    if has('win32unix')
    else
        Plug 'SirVer/ultisnips' " Track the engine. for snippets.
        Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' } " code completion
        " Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode. Does not work with YouCompleteMe
    endif
    Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
    " Code to execute when the plugin is lazily loaded on demand
    Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
    " language support
    Plug 'PProvost/vim-ps1' " powershell syntax coloring
    Plug 'rust-lang/rust.vim' " rust language support
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " golang support
    Plug 'HerringtonDarkholme/yats.vim' " Add a syntax file for typescript. YATS is the best
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'} " typescript support
    Plug 'sheerun/vim-polyglot' " used by nova color schema, multiple programming language support (basic)
    Plug 'mattn/webapi-vim' " webapi neede by rust pluggin
    if !has('nvim')
        Plug 'rhysd/vim-healthcheck'
    endif

    " Initialize plugin system
    call plug#end()

    function! ToggleGUICruft()
      if &guioptions==''
        exec('set guioptions=imTr')
      else
        exec('set guioptions-=imTr')
      endif
    endfunction

" use nord colorscheme
    if has('nvim')
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        set background=dark " light or dark
        colorscheme solarized_nvimqt
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
            set background=dark
            colorscheme solarized
            set guioptions=imTr
            set guioptions-=imTr  "no_icon, menu_bar, toolbar, scrollbar
            nnoremap <F11> <Esc>:call ToggleGUICruft()<cr>
        else
            colorscheme nord 
        endif
    endif

" spell checker
    map <leader>sp :setlocal spell! spelllang=en_us<cr>

" set source code pro font
    set guifont=Source\ Code\ Pro\ for\ Powerline:h16:cANSI
    " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h16:cANSI

" disable highlights
    nnoremap <leader>nh :noh<cr>    

" productivity
    nnoremap <leader>] ]]zz
    nnoremap <leader>[ [[zz
    nnoremap <leader>lu mqO<Esc>`q| " add a line above 
    nnoremap <leader>ld mqo<Esc>`q| " add a line below
    nnoremap <leader>cc <Esc>6i#<Esc>A| " add 6 # and place cursor at the end (comment begin)
    nnoremap <leader>vs :exe ':silent !code %'<CR>:redraw!<CR>

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
    nnoremap <leader>gs  :Gstatus<cr>| " open git status page (from fugitive)

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
    function AltMapping()
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
    nnoremap <silent> <Leader>S :call fzf#run(fzf#wrap( { 'sink': 'botright split', 'down': '40%' } ))<CR>
    nnoremap <silent> <Leader>s :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink': 'botright split', 'down': '40%' } ))<CR>
    " Open files in horizontal split
    nnoremap <silent> <Leader>V :call fzf#run(fzf#wrap( { 'sink':  'vertical botright split', 'right': winwidth('.') / 2 } ))<CR>
    nnoremap <silent> <Leader>v :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink':  'vertical botright split', 'right': winwidth('.') / 2 } ))<CR>
    " Open files in another tab
    nnoremap <silent> <Leader>T :call fzf#run(fzf#wrap( { 'sink':  'tabedit', 'window': 'botright 50vnew' } ))<CR>
    nnoremap <silent> <Leader>t :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink':  'tabedit', 'window': 'botright 50vnew' } ))<CR>
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
    augroup END

    function VimEnterFunction()
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



