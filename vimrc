" vim:set sts=2 sw=2 et:

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype plugin indent on

set nocompatible
set confirm

set encoding=utf-8

set history=10000

set viminfo='50,h,n~/.vim/viminfo

if has("persistent_undo")
  set undodir=$HOME/.vim/_undo,/tmp
  set undofile
endif

set nobackup
set writebackup
set backupdir=$HOME/.vim/_backup,/tmp
set backupcopy=yes
set directory=$HOME/.vim/_swap,/tmp

set switchbuf=useopen
set hidden

set background=dark
colorscheme solarized
syntax enable

set splitright
set winwidth=80

" wh must be >= wmh, but we cannot set wh >> wmh before setting wmh...
set winheight=5
set winminheight=5
set winheight=999
set helpheight=999
set cmdwinheight=999

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
set virtualedit=block

" ignore case while searching...
set ignorecase
" ...unless pattern contains capitals
set smartcase
set incsearch
set hlsearch

set wildmode=longest,full
set wildmenu

set autowrite
set autoread
set autoindent
set expandtab

set completeopt=menuone,longest,preview
set complete-=i
set formatoptions+=r
set listchars=tab:▸\ ,eol:¬

set statusline=[%n]                 " buffer number
set statusline+=%<                  " truncation point
set statusline+=\ %.99f             " relative path to file
set statusline+=%{FugitiveStatuslineWrapper()}
set statusline+=\ %h%w%m%r%y        " h, prev, mod, ro, ft
set statusline+=%=                  " l-r separator
set statusline+=%-14(%3l,%02c%03V%) " line#,col#-vcol#

set notimeout
set ttimeout
set ttimeoutlen=10

" plugin settings
let g:vitality_fix_cursor = 0
let g:CommandTMaxHeight = 12
let g:CommandTMinHeight = 3

" mappings
let mapleader = ","

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

nnoremap <silent> <leader>b :CommandTBuffer<cr>
nnoremap <silent> <leader>f :CommandT<cr>
nnoremap <silent> <leader>F :CommandT %%<cr>

" :bc to write and delete buffer
cnoreabbrev bc w<bar>bd

cnoremap <expr> %% expand("%:h")."/"
map <leader>e :edit %%
map <leader>v :view %%

imap <c-c> <esc>
imap <c-l> <space>=><space>
inoremap <expr> <tab> DwimTab()

nnoremap <leader>l :set list!<cr>

" find merge conflict markers
nnoremap <leader>cf /\v^[<=\|>]{7}\s.*$<cr>

" continuous indentation
vnoremap > >gv
vnoremap < <gv

function! FugitiveStatuslineWrapper()
  let head = fugitive#head(7)
  if head != ""
    return " (".head.")"
  else
    return ""
  endif
endfunction

function! DwimTab()
  if pumvisible()
    return "\<c-n>"
  endif

  let col = col(".") - 1
  if !col || getline(".")[col - 1] !~ '\k'
      return "\<tab>"
  else
      return "\<c-x>\<c-o>"
  endif
endfunction

augroup filetypes
  autocmd!
  autocmd FileType c setlocal noet
  autocmd FileType make setlocal noet
  autocmd FileType ruby,cucumber,yaml,eruby setlocal ai sw=2 sts=2 et
  autocmd FileType sh setlocal ai sw=4 sts=4 et
  autocmd FileType python setlocal ai sw=4 sts=4 et
  autocmd FileType gitconfig setlocal noet
augroup END

augroup completion
  autocmd FileType *
    \ if &omnifunc == "" |
    \   setlocal omnifunc=syntaxcomplete#Complete |
    \ endif
  autocmd FileType *
    \ if &completefunc == "" |
    \   setlocal completefunc=syntaxcomplete#Complete |
    \ endif
augroup END

augroup vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC
augroup END

augroup lastposjump
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute "normal g`\"zvzz" |
    \ endif
augroup END

augroup focus
  autocmd FocusLost * silent! wall
  autocmd FocusGained * silent! call fugitive#reload_status()
augroup END

augroup git
  autocmd!
  autocmd BufReadPost COMMIT_EDITMSG,TAG_EDITMSG exe "normal! gg"
  autocmd BufNewFile,BufRead TAG_EDITMSG setlocal ft=gitcommit
  autocmd BufNewFile,BufRead gitconfig setlocal ft=gitconfig
  autocmd FileType gitrebase nnoremap <buffer> <silent> S :Cycle<cr>
augroup END

augroup hlsearch
  autocmd!
  autocmd VimEnter * doautocmd User MapCR
  autocmd CmdWinEnter * nunmap <cr>
  autocmd CmdWinLeave * doautocmd User MapCR
  autocmd InsertEnter,InsertLeave * set invhlsearch
  autocmd User MapCR nnoremap <silent> <cr> :nohlsearch<cr>
augroup END

augroup paste
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

augroup winscale
  autocmd!
  autocmd VimResized * wincmd =
augroup END

augroup diff
  autocmd!
  autocmd FilterWritePre * if &diff | set nonumber | endif
augroup END

augroup cursorline
  autocmd!
  autocmd WinLeave,InsertEnter * set nocursorline
  autocmd WinEnter,InsertLeave * set cursorline
augroup END

augroup rails
  autocmd!
  autocmd User Rails
   \ map <buffer> <leader>ra :A<cr>|
   \ map <buffer> <leader>rr :R<cr>|
   \ map <buffer> <leader>rg :topleft :split Gemfile<cr>|
   \ map <buffer> <leader>rm :CommandT app/models<cr>|
   \ map <buffer> <leader>rv :CommandT app/views<cr>|
   \ map <buffer> <leader>rc :CommandT app/controllers<cr>|
   \ map <buffer> <leader>rh :CommandT app/helpers<cr>|
   \ map <buffer> <leader>rl :CommandT lib<cr>
augroup END

augroup tests
  autocmd!
  autocmd BufNewFile,BufRead *_spec.rb silent! compiler rspec
  autocmd BufNewFile,BufRead *_test.rb silent! compiler rubyunit
  autocmd BufNewFile,BufRead test_*.rb
    \ silent! compiler rubyunit |
    \ setlocal makeprg=/usr/bin/testrb
  autocmd FileType cucumber silent! compiler cucumber
  autocmd User Bundler
    \ if &makeprg !~# '^bundle' |
    \   setlocal makeprg^=bundle\ exec\  |
    \ endif
augroup END

map <silent> <leader>T :call RunNearestTest()<cr>
map <silent> <leader>t :call RunTestFile()<cr>
map <silent> <leader>a :call RunTests()<cr>

function! InTestFile()
  if !exists("t:test_regexp")
    let t:test_regexp = '\v(\.feature|_spec\.rb|_test\.rb|test_.+\.rb)$'
  endif

  if expand("%") =~# t:test_regexp
    return 1
  else
    return 0
  endif
endfunction

function! RunNearestTest()
  if InTestFile()
    call RunTestFile(":" . line("."))
  endif
endfunction

function! RunTestFile(...)
  if a:0 == 1
    let suffix = a:1
  else
    let suffix = ""
  endif

  if InTestFile()
    call RunTests(expand("%") . suffix)
  endif
endfunction

function! RunTests(...)
  if !InTestFile()
    return
  endif

  silent write

  let cmd = "!".&makeprg." "

  if a:0 == 1
    let cmd .= a:1
  elseif a:0 == 2
    let cmd .= a:1.":".a:2
  endif

  exec cmd
  redraw!
endfunction
