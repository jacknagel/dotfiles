scriptencoding utf-8

packadd! matchit

set nocompatible
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set backupdir^=~/.vim/_backup//
set backupskip&
set backupskip+=/private/tmp/*
set belloff=all
set cmdheight=2
set complete-=i
set completeopt=menuone,longest,preview
set cursorline
set dictionary+=/usr/share/dict/words
set directory^=~/.vim/_swap//
set display=lastline
set fillchars=vert:│,fold:·
set formatoptions+=1rj
set history=200
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set listchars=tab:▸\ ,trail:·,extends:…,precedes:…,nbsp:␠
set noequalalways
set nojoinspaces
set nolangremap
set nrformats-=octal
set number
set numberwidth=3
set report=0
set scrolloff=5
set sessionoptions-=options
set shiftround
set shortmess=aFIoOtT
set showcmd
set sidescroll=1
set sidescrolloff=5
set smarttab
set spellfile=~/.vim/spell/en.utf-8.add,~/.vim/spell/en-local.utf-8.add
set spelllang=en_us
set splitbelow
set splitright
set switchbuf=useopen
set tags+=./tags;
set thesaurus+=~/.vim/spell/mthesaur.txt
set timeoutlen=1200
set title
set ttimeout
set ttimeoutlen=50
set undodir^=~/.vim/_undo
set undofile
set viminfo+=n~/.vim/viminfo
set viminfo^=!
set virtualedit+=block
set wildignore+=*.[aos],*.aux,*.class,*.dSYM,*.dylib,*.out,*.py[co],*.so,.DS_Store
set wildignore+=*~,Session.vim,Sessionx.vim,[._]*.s[a-v][a-z],[._]*.sw[a-p],[._]s[a-v][a-z],[._]sw[a-p],[._]*.un~,tags
set wildmenu
set wildmode=longest:full,full
set winheight=10
set winminheight=10
set winwidth=80

set statusline=[%n]                 " buffer number
set statusline+=%(\ %.120f\ %)      " relative path to file
set statusline+=%h%w%m%r%y          " help|preview|modified|readonly|filetype
set statusline+=%{FugitiveStatusline()}
set statusline+=%=                  " l-r separator
set statusline+=%-10.(0x%B%)        " hex value of character under cursor
set statusline+=%-15.(%l,%c%V%)\ %P " line#,col#-vcol# %

filetype plugin indent on
syntax enable

if $COLORTERM ==# 'truecolor'
  if has('termguicolors')
    set termguicolors
  endif

  silent! colorscheme deep-space
endif

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m
elseif executable('ggrep')
  set grepprg=ggrep\ -rnHI\ --exclude-dir=.git\ --exclude=tags
else
  set grepprg=grep\ -rnHI\ --exclude-dir=.git\ --exclude=tags
endif

" plugin settings
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_pattern_options = {
  \ '/node_modules/': { 'ale_enabled': 0 },
  \}
let g:jsx_ext_required = 1
let g:markdown_fenced_languages = [
  \ 'bash=sh',
  \ 'css',
  \ 'go',
  \ 'html',
  \ 'java',
  \ 'javascript',
  \ 'js=javascript',
  \ 'json',
  \ 'python',
  \ 'ruby',
  \ 'shell=sh',
  \ 'sql',
  \ 'swift',
  \ 'terraform',
  \ 'yaml',
  \]
let g:no_default_tabular_maps = 1
let g:terraform_fmt_on_save = 1
let g:vim_indent_cont = 2
let g:vim_json_syntax_conceal = 0

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

" make Q work like gq instead of switching
map Q gq

" make Y work like y$ instead of yy
nmap Y y$

" In insert mode, break the current undo sequence in sensible places. If <CR>
" is already mapped to include <C-G>u, then don't remap it. This preserves the
" endwise.vim <CR> mapping when re-sourcing this file.
if maparg('<CR>', 'i') !~# '<C-G>u<CR>'
  inoremap <CR> <C-G>u<CR>
endif
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" make & include flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" make Ctrl-C check abbreviations and trigger InsertLeave
inoremap <C-C> <Esc>

" continuous indentation
vnoremap > >gv
vnoremap < <gv

" clear search highlighting
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

function! s:sort_opfunc(...)
  '[,']sort
endfunction
nnoremap <silent> gs :set operatorfunc=<SID>sort_opfunc<CR>g@
vnoremap <silent> gs :sort<CR>

noremap gy "*y

nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap yol :setlocal invlist<CR>
nnoremap yow :setlocal invwrap<CR>

function! s:restore_last_cursor_position()
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
  autocmd BufNewFile,BufReadPost *.log{,.[0-9]*} setlocal readonly bufhidden=unload buftype=nowrite noundofile nowrap
  autocmd BufNewFile,BufReadPost */node_modules/* setlocal readonly
  autocmd BufNewFile,BufReadPost .npmignore setlocal ft=conf
  autocmd BufNewFile,BufReadPost .npmrc setlocal ft=dosini
augroup END

augroup vimrc
  autocmd!
  autocmd BufWritePost {,.}vimrc source <afile>
  autocmd BufWritePost */spell/*.add silent! mkspell! <afile>
augroup END

augroup lastposjump
  autocmd!
  autocmd BufReadPost *.log{,.[0-9]*} delmarks \"
  autocmd BufReadPost quickfix delmarks \"
  autocmd BufReadPost * call s:restore_last_cursor_position()
augroup END

augroup undo
  autocmd!
  autocmd CursorHoldI * silent! call feedkeys("\<C-G>u", "nt")
  autocmd BufWritePre /tmp/*,$TMPDIR/*,/{private,var,private/var}/tmp/*,/{var,private/var}/folders/* setlocal noundofile
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
  autocmd!
  autocmd FilterWritePre * if &diff | set nonumber | endif
  autocmd VimEnter * nested if &lazyredraw | redrawstatus! | endif
  autocmd VimResized * nested wincmd =
  autocmd WinEnter * nested if &buftype != 'quickfix' | resize | set cursorline | endif
  autocmd WinLeave * set nocursorline
augroup END

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested botright cwindow | wincmd p
  autocmd QuickFixCmdPost l* nested botright lwindow
  autocmd VimEnter * nested if filereadable(&errorfile) | botright cwindow | wincmd p | endif
augroup END

silent! source ~/.vimrc.local
