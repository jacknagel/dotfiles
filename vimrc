" ~/.vimrc: vim(1) configuration

"
" magic to load plugins using pathogen
"

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

"
" General
"
set nocompatible                        " vim, not vi (always first)
set confirm                             " confirm some commands when ! is omitted
set history=1000                        " remember 1000 lines of history
set clipboard+=unnamed                  " yanks also go to the clipboard
set autoread                            " reload files (no local changes)
set tabpagemax=20                       " open 20 tabs max
set viminfo=%,'50,n~/.vim/.viminfo      " save buffer list and move .viminfo
set undodir=$HOME/.vim/undo,/tmp        " undo file directory
set undofile                            " keep undo files
set pastetoggle=<F2>                    " Press <F2> for paste mode


"
" Backups
"
set nobackup                            " do not keep backup files after close
set writebackup                         " keep backup files while working
set backupdir=$HOME/.vim/backups,/tmp   " store backups in ~/.vim/backups
set backupcopy=yes                      " preserve file attributes
set directory=$HOME/.vim/tmp,/tmp       " swap file directory


"
" UI
"
set ruler                               " show cursor position all the time
set number                              " show line numbers
set columns=80                          " width of editor
set scrolloff=5                         " number of context lines
set backspace=2                         " make backspace work like it should
set nostartofline                       " stop
set timeoutlen=200                      " time to wait after hitting ESC (in ms)
set cmdheight=2                         " command line height
set wildmenu                            " better tab completion
set wildmode=list:longest,full          " better tab completion
set visualbell                          " be quiet, but flashy
set report=0                            " report all changes
" set laststatus=2                      " always show status line
set showmatch                           " show matching brackets/braces
set mat=5                               " duration to show matches (in 1/10 s)
set ignorecase                          " ignore case while searching
set smartcase                           " except when specifying capital letters


"
" Visual
"
syntax on                               " enable syntax highlighting
" set list listchars=trail:.,tab:>.     " make tabs visible but not ugly; off normally
colorscheme delek
highlight LineNr ctermfg=grey


"
" Text Formatting
"
set nowrap                              " do not wrap lines
set autoindent                          " automatically indent new lines
set copyindent                          " make autoindent use existing indent structure
set preserveindent                      " preserve indent structure when reindenting
set formatoptions+=r			" insert comment leader automatically
