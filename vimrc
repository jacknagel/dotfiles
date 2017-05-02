" vim:set et sw=2:

execute pathogen#infect()
runtime macros/matchit.vim

set nocompatible
filetype plugin indent on
syntax on

set history=1000
set viminfo^=!
set viminfo+=n~/.vim/viminfo
set backupdir^=~/.vim/_backup//
set backupskip&
set backupskip+=/private/tmp/*
set directory^=~/.vim/_swap//
set undodir^=~/.vim/_undo
set undofile
set sessionoptions-=options
set autowrite
set autoread

set number
set numberwidth=3
set scrolloff=3
set backspace=indent,eol,start
set cmdheight=2
set showcmd
set visualbell
set report=0
set laststatus=2
set cursorline
set shortmess=aIoOtT
set lazyredraw
set virtualedit+=block
set nojoinspaces
set display=lastline

set incsearch
set hlsearch

set autoindent
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

set statusline=[%n]                 " buffer number
set statusline+=\ %.99f             " relative path to file
set statusline+=%{FugitiveStatuslineWrapper()}
set statusline+=\ %h%w%m%r%y        " help|preview|modified|readonly|filetype
set statusline+=%=                  " l-r separator
set statusline+=%-14.(%l,%c%V%)\ %P " line#,col#-vcol# %

set ttimeout
set timeoutlen=1200
set ttimeoutlen=50

setglobal tags+=./tags;

set wildmenu
set wildmode=longest:full,full
set wildignore+=*~,[._]*.s[a-v][a-z],[._]*.sw[a-p],[._]s[a-v][a-z],[._]sw[a-p],Session.vim
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

if has('termguicolors') && $TERM_PROGRAM ==# 'iTerm.app'
  set termguicolors
  set background=dark
  colorscheme solarized8_dark
endif

" plugin settings
let g:vim_json_syntax_conceal = 0

let g:html_indent_script1 = 'inc'
let g:html_indent_style1  = 'inc'
let g:html_indent_inctags = 'body,dd,dt,head,html,li,p,tbody'

" mappings
let g:mapleader = ','

map  <Left>  <Nop>
map  <Right> <Nop>
map  <Up>    <Nop>
map  <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>
imap <Up>    <Nop>
imap <Down>  <Nop>

" never switch to ex mode
nmap Q <Nop>
nmap gQ <Nop>

" In insert mode, break the current undo sequence in sensible places. If <CR>
" is already mapped to include <C-G>u, then don't remap it. This preserves the
" endwise.vim <CR> mapping when re-sourcing this file.
if maparg('<CR>', 'i') !~ '<C-G>u<CR>'
  inoremap <CR> <C-G>u<CR>
endif
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" make & include flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" switch to previous file
nnoremap <Leader><Leader> <C-^>

" make Ctrl-C check abbreviations and trigger InsertLeave
inoremap <C-C> <Esc>

nnoremap <Leader>l :set list!<CR>

" add word under cursor to unversioned spellfile
nnoremap zG 2zg

" continuous indentation
vnoremap > >gv
vnoremap < <gv

" clear search highlighting
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

function! FugitiveStatuslineWrapper()
  if !exists('*fugitive#head')
    return ''
  endif

  let head = fugitive#head(7)
  return head ==# '' ? '' : ' [' . head . ']'
endfunction

function! s:restore_last_cursor_position()
  if &l:filetype == "gitcommit" || &l:filetype == "gitrebase" || &l:buftype == "quickfix"
    return
  endif

  " If the last cursor position is on the first line or past the end of the
  " file, don't do anything.
  if line("'\"") == 0 || line("'\"") > line("$")
    return
  endif

  " Jump to the last cursor position. If it is not in the bottom half of the
  " last window, then re-center the window on the line.
  if line("$") - line("'\"") > (line("w$") - line("w0")) / 2
    execute "normal! g`\"zz"
  else
    execute "normal! g`\""
  endif
endfunction

augroup filetypes
  autocmd!
  autocmd FileType gitcommit              setlocal spell
  autocmd FileType gitcommit,gitrebase    setlocal nonumber noundofile
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
  autocmd BufNewFile,BufReadPost *.log{,.[0-9]*} setlocal readonly nowrap
  autocmd BufNewFile,BufReadPost */node_modules/* setlocal readonly
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
  autocmd BufReadPost * call s:restore_last_cursor_position()
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

augroup windows
  " Initially, &wmh == 1 and &wh == 1. Setting &wmh > &wh is disallowed,
  " as is setting 'wmh' after setting 'wh' sufficiently large to prevent
  " opening another window.
  autocmd!
  autocmd VimEnter * set wh=10 wmh=10 wh=999 hh=999 cwh=999
  autocmd VimEnter * set wiw=80
  autocmd VimResized * wincmd =
  autocmd VimEnter * if &lazyredraw | redrawstatus! | endif
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
