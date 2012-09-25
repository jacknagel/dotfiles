" ~/.vimrc: vim(1) configuration

call pathogen#infect()
filetype plugin indent on

" General
set nocompatible                        " vim, not vi (always first)
set confirm                             " confirm some commands when ! is omitted
set history=10000                       " remember 1000 lines of history
set clipboard+=unnamed                  " yanks also go to the clipboard
set autoread                            " reload files (no local changes)
set tabpagemax=20                       " open 20 tabs max
set viminfo=%,'50,n~/.vim/viminfo       " save buffer list and move .viminfo
set undodir=$HOME/.vim/_undo,/tmp       " undo file directory
set undofile                            " keep undo files
set pastetoggle=<F2>                    " Press <F2> for paste mode


" Backups
set nobackup                            " do not keep backup files after close
set writebackup                         " keep backup files while working
set backupdir=$HOME/.vim/_backup,/tmp   " store backups in ~/.vim/backups
set backupcopy=yes                      " preserve file attributes
set directory=$HOME/.vim/_tmp,/tmp      " swap file directory


" UI
set ruler                               " show cursor position all the time
set number                              " show line numbers
set numberwidth=3                       " line number width
set scrolloff=3                         " number of context lines
set backspace=2                         " make backspace work like it should
set timeoutlen=200                      " time to wait after hitting ESC (in ms)
set cmdheight=2                         " command line height
set wildmenu                            " better tab completion
set wildmode=list:longest,full          " better tab completion
set visualbell                          " be quiet, but flashy
set report=0                            " report all changes
set laststatus=2                        " always show status line
set showtabline=2                       " always show tab line
set showmatch                           " show matching brackets/braces
set mat=5                               " duration to show matches (in 1/10 s)
set ignorecase                          " ignore case while searching...
set smartcase                           " ...except when specifying capital letters
set incsearch
set hlsearch
set switchbuf=useopen                   " use existing windows when possible


" Visual
set background=dark
syntax on                               " enable syntax highlighting
" set list listchars=trail:.,tab:>.     " make tabs visible but not ugly; off normally
colorscheme delek
highlight LineNr ctermfg=grey


" Text Formatting
set nowrap                              " do not wrap lines
set autoindent                          " automatically indent new lines
set copyindent                          " make autoindent use existing indent structure
set preserveindent                      " preserve indent structure when reindenting
set formatoptions+=r                    " insert comment leader automatically


set statusline=
set statusline+=%{fugitive#statusline()} " git branch, TODO customize
set statusline+=\ %f                     " file path
set statusline+=\ %-4(%m%)               " modified flag
set statusline+=%=                       " l-r separator
set statusline+=%-16(%3l,%02c%03V%)      " line#,col#-vcol#


" Mappings
let mapleader=","
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

nnoremap <silent> <cr> :nohlsearch<cr>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


" autocmds
augroup vimrc
  autocmd!

  autocmd FileType ruby setlocal ai sw=2 sts=2 et
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END