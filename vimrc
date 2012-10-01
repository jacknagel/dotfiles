" vim:set ts=2 sts=2 sw=2 et:

call pathogen#infect()
filetype plugin indent on

set nocompatible
set confirm

set history=10000

set viminfo=%,'50,n~/.vim/viminfo
set undodir=$HOME/.vim/_undo,/tmp
set undofile

set nobackup
set writebackup
set backupdir=$HOME/.vim/_backup,/tmp
set backupcopy=yes
set directory=$HOME/.vim/_tmp,/tmp

set switchbuf=useopen
set hidden

set background=dark
colorscheme solarized
syntax enable

set winwidth=80
set winheight=30
set winminheight=5

set ruler
set number
set numberwidth=3
set scrolloff=3
set backspace=2
set cmdheight=2
set showcmd
set visualbell
set report=0
set laststatus=2
set showtabline=2
set cursorline
set showmatch
set timeoutlen=10

" ignore case while searching...
set ignorecase
" ...unless pattern contains capitals
set smartcase
set incsearch
set hlsearch

set wildmode=longest,full
set wildmenu

set autoindent
set expandtab
set formatoptions+=r

set listchars=tab:▸\ ,eol:$

set statusline=
set statusline+=%{fugitive#statusline()} " git branch
set statusline+=\ %f                     " file path
set statusline+=\ %-4(%m%)               " modified flag
set statusline+=%=                       " l-r separator
set statusline+=%-16(%3l,%02c%03V%)      " line#,col#-vcol#


" mappings
let mapleader=","

map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <up> <nop>
imap <down> <nop>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

imap <c-c> <esc>

nnoremap <leader>l :set list!<cr>

function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" command-t
let g:CommandTMaxHeight=12
let g:CommandTMinHeight=3

augroup vimrc
  autocmd!

  autocmd FileType c setlocal noet
  autocmd FileType make setlocal noet
  autocmd FileType ruby,cucumber,yaml,eruby setlocal ai sw=2 sts=2 et

  autocmd BufWritePost *vimrc source $MYVIMRC
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
  autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"
augroup END
