"
" ~/.vimrc
"
" vim has a. lot. of. options., but this is a good starting point
"

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

"
" General
"
set nocompatible                        " always set this
set confirm                             " confirm some commands when ! is omitted
set history=1000                        " remember 1000 lines of history
set clipboard+=unnamed                  " yanks go on the clipboard
set autoread                            " reload files (no local changes)
set tabpagemax=20                       " open 20 tabs max
set viminfo=%,'50,n~/.vim/.viminfo      " save buffer list and move .viminfo
set undodir=$HOME/.vim/undodir          " undo file directory
set undofile                            " keep undo files


"
" Backups
"
set nobackup                            " do not keep backup files after close
set writebackup                         " keep backup files while working
set backupdir=$HOME/.vim/backups        " store backups in ~/.vim/backups
set backupcopy=yes                      " preserve file attributes
set directory=$HOME/.vim/tmp            " swap file directory


"
" UI
"
set ruler                               " show cursor position all the time
set number                              " show line numbers
set columns=80                          "
set backspace=2                         " make backspace work like it should
set nostartofline                       " stop
set timeoutlen=200                      " time to wait after hitting ESC (in ms)
set cmdheight=2                         " command line height
set wildmenu                            " better tab completion
set wildmode=list:longest,full          " better tab completion
set report=0                            " report all changes
set visualbell                          " be quiet
" set laststatus=2                      " always show status line
set showmatch                           " show matching brackets/braces
set mat=5                               " duration to show matches (in 1/10 s)
set ignorecase                          " ignore case while searching
set smartcase                           " except when specifying capital letters


"
" Colors & Theme
"
syntax on                               " enable syntax highliting
" set list listchars=trail:.,tab:>.     " make tabs visible but not ugly


"
" Text Formatting
"
set autoindent                          " automatically indent new lines
set smartindent                         "
set copyindent                          "
set nowrap                              " do not wrap lines
set softtabstop=4                       "
set shiftwidth=4                        "
set tabstop=4                           "
set expandtab                           "
set smarttab                            "
