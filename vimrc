" vim:set et sw=2:

execute pathogen#infect()

filetype plugin indent on

runtime macros/matchit.vim

set nocompatible
set encoding=utf-8
set history=1000
set viminfo=!,'50,<50,s10,h,n$HOME/.vim/viminfo

if has("persistent_undo")
  set undodir^=$HOME/.vim/_undo
  set undofile
endif

set nobackup
set writebackup
set backupdir^=$HOME/.vim/_backup//
set backupskip+=/private/tmp/*
set directory^=$HOME/.vim/_swap//
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

set timeout
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
set wildignore+=tmp/**
set wildignore+=bundle/**,vendor/bundle/**,vendor/cache/**
set wildignore+=node_modules/**

set spelllang=en_us
set spellfile=$HOME/.vim/spell/en.utf-8.add,$HOME/.vim/spell/en-local.utf-8.add
set dictionary+=/usr/share/dict/words
set thesaurus+=$HOME/.vim/spell/mthesaur.txt

set splitbelow
set splitright

" plugin settings
let g:vitality_fix_cursor = 0
let g:vim_json_syntax_conceal = 0

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
  autocmd FileType c                      setlocal ai et sw=4
  autocmd FileType make                   setlocal ai noet
  autocmd FileType gitconfig              setlocal ai noet
  autocmd FileType sql                    setlocal ai et sw=2
  autocmd FileType ruby,cucumber,yaml     setlocal ai et sw=2
  autocmd FileType css,scss,sass          setlocal ai et sw=2 isk+=-
  autocmd FileType javascript,coffee      setlocal ai et sw=2 isk+=$
  autocmd FileType eruby,haml,html,slim   setlocal ai et sw=2
  autocmd FileType sh                     setlocal ai et sw=2
  autocmd FileType python                 setlocal ai et sw=4
  autocmd Filetype java                   setlocal ai et sw=4
  autocmd FileType help,qf                nnoremap <silent> <buffer> q :<C-U>q<CR>
  autocmd FileType vim                    setlocal ai et sw=2 sua=.vim
  autocmd FileType vim,help               setlocal kp=:help
  autocmd FileType vim,help               let &l:path = escape(&runtimepath, ' ')
  autocmd FileType sh                     let &l:path = substitute($PATH, ':', ',', 'g')
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

augroup compilers
  autocmd!
  autocmd FileType cucumber             silent! compiler cucumber
  autocmd FileType sass,scss            silent! compiler sass
  autocmd FileType haml                 silent! compiler haml
  autocmd BufNewFile,BufRead *_spec.rb  silent! compiler rspec
  autocmd BufNewFile,BufRead *_test.rb  silent! compiler rubyunit
  autocmd BufNewFile,BufRead test_*.rb
    \ silent! compiler rubyunit |
    \ setlocal makeprg=ruby\ -I%:h
  autocmd User Bundler
    \ if &makeprg !~# '^bundle' |
    \   setlocal makeprg^=bundle\ exec\  |
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

augroup undo
 autocmd!
 autocmd CursorHoldI * silent! call feedkeys("\<C-G>u", "nt")
augroup END

augroup focus
  autocmd!
  autocmd FocusLost * silent! wall
  autocmd FocusGained * silent! call fugitive#reload_status()
augroup END

augroup swapmod
  autocmd!
  autocmd CursorHold,CursorHoldI,BufWritePost,BufReadPost,BufLeave *
    \ if !empty(map(split(&directory, ","), "isdirectory(expand(v:val))")) |
    \   let &swapfile = &modified |
    \ endif
augroup END

augroup git
  autocmd!
  autocmd BufReadPost *.git/{,modules/**/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG exe "normal! gg"
  autocmd BufNewFile,BufRead gitconfig setf gitconfig
  autocmd FileType gitcommit set spell nonumber
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
