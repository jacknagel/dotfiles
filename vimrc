" vim:set sts=2 sw=2 et:

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype plugin indent on

runtime macros/matchit.vim

set nocompatible

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
set backupskip+=/private/tmp/*
set directory=$HOME/.vim/_swap//,.
set autowrite
set autoread

set switchbuf=useopen
set hidden

set background=dark
colorscheme solarized
syntax enable

set number
set numberwidth=3
set scrolloff=3
set backspace=indent,eol,start
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
let g:ctrlp_map = "<leader>f"
let g:ctrlp_max_height = 12
let g:ctrlp_cache_dir = $HOME."/.vim/_cache/ctrlp"
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_extensions = ['undo']

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

nnoremap <silent> <leader>b :CtrlPBuffer<cr>
nnoremap <silent> <leader>f :CtrlP<cr>
nnoremap <silent> <leader>F :CtrlP %%<cr>

" :bc to write and delete buffer
cnoreabbrev bc w<bar>bd

cnoremap <expr> %% getcmdtype() == ":" ? expand("%:h")."/" : "%%"
nmap <leader>e :edit %%
nmap <leader>v :view %%

" quickfix navigation
nnoremap <silent> ]q :<C-U>exe "cnext".v:count1<cr>
nnoremap <silent> [q :<C-U>exe "cprev".v:count1<cr>

inoremap <c-c> <esc>
inoremap <c-l> <space>=><space>

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

augroup filetypes
  autocmd!
  autocmd FileType c                     setlocal ai noet sta cin
  autocmd FileType make                  setlocal ai noet sta
  autocmd FileType gitconfig             setlocal ai noet sta
  autocmd FileType ruby,cucumber,yaml    setlocal ai et sta sw=2 sts=2
  autocmd FileType css,scss,sass         setlocal ai et sta sw=2 sts=2
  autocmd FileType javascript            setlocal ai et sta sw=2 sts=2 cin
  autocmd FileType eruby,haml,html       setlocal ai et sta sw=2 sts=2
  autocmd FileType sh                    setlocal ai et sta sw=4 sts=4
  autocmd FileType python                setlocal ai et sta sw=4 sts=4
  autocmd FileType eruby,html
    \ if g:html_indent_tags !~# '\v\|p>' |
    \   let g:html_indent_tags .= '\|p\|li\|dt\|dd\|nav\|header\|footer' |
    \ endif
  autocmd FileType help nnoremap <silent> <buffer> q :q<cr>
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

augroup swapmod
  autocmd!
  autocmd CursorHold,CursorHoldI,CursorMoved,CursorMovedI,BufWritePost,BufReadPost,BufLeave *
    \ if !empty(map(split(&directory, ","), "isdirectory(expand(v:val))")) |
    \   let &swapfile = &modified |
    \ endif
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

augroup windows
  " Initially, &wmh == 1 and & wh == 1. Setting &wmh > &wh is disallowed,
  " as is setting 'wmh' after setting 'wh' sufficiently large to prevent
  " opening another window.
  autocmd!
  autocmd VimEnter * set wh=5 wmh=5 wh=999 hh=999 cwh=999
  autocmd VimEnter * set wiw=80
  autocmd VimEnter * set splitright
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
   \ nnoremap <buffer> <leader>ra :A<cr>|
   \ nnoremap <buffer> <leader>rr :R<cr>|
   \ nnoremap <buffer> <leader>rg :topleft :split Gemfile<cr>|
   \ nnoremap <buffer> <leader>rm :CtrlP app/models<cr>|
   \ nnoremap <buffer> <leader>rv :CtrlP app/views<cr>|
   \ nnoremap <buffer> <leader>rc :CtrlP app/controllers<cr>|
   \ nnoremap <buffer> <leader>rh :CtrlP app/helpers<cr>|
   \ nnoremap <buffer> <leader>rl :CtrlP lib<cr>
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
