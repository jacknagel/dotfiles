" vim:set et sw=2:

execute pathogen#infect()

filetype plugin indent on

runtime macros/matchit.vim

set nocompatible
set history=1000
set viminfo^=!
set viminfo+=n~/.vim/viminfo

set backupdir^=~/.vim/_backup//
set backupskip+=/private/tmp/*
set directory^=~/.vim/_swap//
set undodir^=~/.vim/_undo
set undofile
set autowrite
set autoread

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
set virtualedit+=block
set nojoinspaces

set incsearch
set hlsearch

set autoindent
set expandtab
set smarttab
set shiftround

set completeopt=menuone,longest,preview
set complete-=i

set nrformats-=octal
set formatoptions+=1r

if v:version >= 704
  set formatoptions+=j
endif

set listchars=tab:▸\ ,eol:$

set statusline=%<                   " truncation point
set statusline+=[%n]                " buffer number
set statusline+=\ %.99f             " relative path to file
set statusline+=%{FugitiveStatuslineWrapper()}
set statusline+=\ %h%w%m%r%y        " help|preview|modified|readonly|filetype
set statusline+=%=                  " l-r separator
set statusline+=%-14(%3l,%02c%03V%) " line#,col#-vcol#

set ttimeout
set timeoutlen=1200
set ttimeoutlen=50

setglobal tags+=./tags;

set wildmenu
set wildmode=longest:full,full
set wildignore+=*~,[._]*.s[a-w][a-z],[._]s[a-w][a-z],*.un~,Session.vim
set wildignore+=.DS_Store
set wildignore+=tags
set wildignore+=*.aux,*.out
set wildignore+=*.class,*.pyc
set wildignore+=*.[oa],*.so,*.dylib

set spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add,~/.vim/spell/en-local.utf-8.add
set dictionary+=/usr/share/dict/words
set thesaurus+=~/.vim/spell/mthesaur.txt

set splitbelow
set splitright

" plugin settings
let g:vim_json_syntax_conceal = 0
let g:commentary_map_backslash = 0

let g:html_indent_script1 = "inc"
let g:html_indent_style1  = "inc"
let g:html_indent_inctags = "body,dd,dt,head,html,li,p,tbody"

" mappings
let mapleader = ","

map  <Left>  <Nop>
map  <Right> <Nop>
map  <Up>    <Nop>
map  <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>
imap <Up>    <Nop>
imap <Down>  <Nop>
nmap Q       <Nop>

nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" break undo in sensible places
inoremap <CR>  <C-G>u<CR>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" make & include flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" switch to previous file
nnoremap <Leader><Leader> <C-^>

" :bc to write and delete buffer
cnoreabbrev bc w<Bar>bd

inoremap <C-C> <Esc>

nnoremap <Leader>l :set list!<CR>

" add word under cursor to unversioned spellfile
nnoremap zG 2zg

" continuous indentation
vnoremap > >gv
vnoremap < <gv

function! s:map_CR()
  nnoremap <silent> <CR> :nohlsearch<CR>
endfunction

function! FugitiveStatuslineWrapper()
  if !exists('*fugitive#head')
    return ""
  endif

  let head = fugitive#head(7)
  return head == "" ? "" : " [".head."]"
  endif
endfunction

augroup filetypes
  autocmd!
  autocmd FileType gitcommit              setlocal spell nonumber noundofile
  autocmd FileType c                      setlocal ai et sw=4
  autocmd FileType make                   setlocal ai noet
  autocmd FileType gitconfig              setlocal ai noet
  autocmd FileType sshconfig              setlocal ai noet
  autocmd FileType sql                    setlocal ai et sw=2
  autocmd FileType ruby,yaml              setlocal ai et sw=2
  autocmd FileType css,scss,sass,less     setlocal ai et sw=2
  autocmd FileType cucumber               setlocal ai et sw=2 nowrap
  autocmd FileType javascript             setlocal ai et sw=2
  autocmd FileType json                   setlocal ai et sw=2
  autocmd FileType html,eruby             setlocal ai et sw=2
  autocmd FileType sh                     setlocal ai et sw=2
  autocmd FileType python                 setlocal ai et sw=4
  autocmd Filetype java                   setlocal ai et sw=4
  autocmd FileType help,qf                nnoremap <silent> <buffer> q :<C-U>q<CR>
  autocmd FileType vim                    setlocal ai et sw=2 sua=.vim
  autocmd FileType vim,help               setlocal kp=:help
  autocmd FileType vim,help               let &l:path = escape(&runtimepath, ' ')
  autocmd FileType sh                     let &l:path = substitute($PATH, ':', ',', 'g')
  autocmd Syntax css,scss,sass,less       setlocal isk+=-
  autocmd Syntax javascript               setlocal isk+=$
augroup END

augroup readonly
  autocmd BufNewFile,BufRead */node_modules/* setlocal readonly
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
    \ if line("'\"") > 0 && line("'\"") <= line("$") && &l:filetype !=# 'gitcommit' |
    \   execute "normal g`\"zvzz" |
    \ endif
augroup END

augroup undo
 autocmd!
 autocmd CursorHoldI * silent! call feedkeys("\<C-G>u", "nt")
 autocmd BufWritePre /tmp/*,$TMPDIR/*,/{private,var,private/var}/tmp/* setlocal noundofile
augroup END

augroup focus
  autocmd!
  autocmd FocusLost * silent! wall
augroup END

augroup swapmod
  autocmd!
  autocmd CursorHold,CursorHoldI,BufWritePost,BufReadPost,BufLeave *
    \ if !empty(filter(split(&directory, ","), "isdirectory(expand(v:val))")) |
    \   let &swapfile = &modified |
    \ endif
augroup END

augroup hlsearch
  autocmd!
  autocmd VimEnter * call s:map_CR()
  autocmd CmdWinEnter * nunmap <CR>
  autocmd CmdWinLeave * call s:map_CR()
  autocmd InsertEnter,InsertLeave * set hlsearch!
augroup END

augroup windows
  " Initially, &wmh == 1 and &wh == 1. Setting &wmh > &wh is disallowed,
  " as is setting 'wmh' after setting 'wh' sufficiently large to prevent
  " opening another window.
  autocmd!
  autocmd VimEnter * set wh=5 wmh=5 wh=999 hh=999 cwh=999
  autocmd VimEnter * set wiw=80
  autocmd VimResized * wincmd =
augroup END

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost l* nested lwindow
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
