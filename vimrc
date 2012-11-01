" vim:set sts=2 sw=2 et:

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype plugin indent on

set nocompatible
set confirm

set encoding=utf-8

set history=10000

set viminfo='50,n~/.vim/viminfo

if has("persistent_undo")
  set undodir=$HOME/.vim/_undo,/tmp
  set undofile
endif

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

set splitright
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
set shortmess=aIoOtT
set lazyredraw

" ignore case while searching...
set ignorecase
" ...unless pattern contains capitals
set smartcase
set incsearch
set hlsearch

set wildmode=longest,full
set wildmenu

set autoread
set autoindent
set expandtab

set completeopt=menuone,longest,preview
set formatoptions+=r

set listchars=tab:▸\ ,eol:$

set statusline=
set statusline+=%<                       " truncation point
set statusline+=\ %{FugitiveStatuslineWrapper()}
set statusline+=\ %f                     " relative path to file
set statusline+=\ %m%r%y                 " modified, readonly, filetype
set statusline+=%=                       " l-r separator
set statusline+=%-16(%3l,%02c%03V%)      " line#,col#-vcol#

set notimeout
set ttimeout
set ttimeoutlen=50

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

" switch to previous file
nnoremap <leader><leader> <c-^>

cnoremap %% <c-r>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

imap <c-c> <esc>
imap <c-l> <space>=><space>

nnoremap <leader>l :set list!<cr>

function! MapCR()
  nnoremap <silent> <cr> :nohlsearch<cr>
endfunction
call MapCR()

function! FugitiveStatuslineWrapper()
  let head = fugitive#head(7)
  if head != ''
    return '('.head.')'
  else
    return ''
  endif
endfunction

" convert camelCase to snake_case
vnoremap <leader>case :s/\v\C([A-Z]?[a-z]+)([A-Z])/\L\1_\2/g<cr>

" find merge conflict markers
nnoremap <leader>cf /\v^[<=\|>]{7}\s.*$<cr>

" command-t
let g:CommandTMaxHeight=12
let g:CommandTMinHeight=3

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-p>"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

augroup vimrc
  autocmd!

  " SuperTab completion chaining
  autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \   call SuperTabSetDefaultCompletionType("context") |
    \ endif

  autocmd FileType c setlocal noet
  autocmd FileType make setlocal noet
  autocmd FileType ruby,cucumber,yaml,eruby setlocal ai sw=2 sts=2 et
  autocmd FileType sh setlocal ai sw=4 sts=4 et
  autocmd FileType python setlocal ai sw=4 sts=4 et
  autocmd Filetype gitconfig setlocal noet

  autocmd BufWritePost *vimrc source $MYVIMRC
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
  autocmd BufReadPost COMMIT_EDITMSG,TAG_EDITMSG exe "normal! gg"

  autocmd BufNewFile,BufRead TAG_EDITMSG setlocal ft=gitcommit
  autocmd BufNewFile,BufRead gitconfig setlocal ft=gitconfig

  autocmd CmdWinEnter * :unmap <cr>
  autocmd CmdWinLeave * :call MapCR()

  autocmd VimResized * :wincmd =

  autocmd FilterWritePre * if &diff | set nonumber | endif
augroup END
