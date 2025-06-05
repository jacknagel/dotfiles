scriptencoding utf-8

packadd! matchit
runtime! ftplugin/man.vim

set nocompatible
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set belloff=all
set cmdheight=2
set complete-=i
set completeopt=menuone,longest,preview
set cursorline
set dictionary+=/usr/share/dict/words
set display=truncate
set fillchars=vert:│,fold:·
set formatoptions+=1rj
set history=200
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set listchars=tab:▸\ ,trail:·,extends:⇢,precedes:⇠,nbsp:␠
set noequalalways
set nojoinspaces
set nolangremap
set nrformats-=octal
set nrformats+=unsigned
set number
set numberwidth=3
set report=0
set scrolloff=1
set sessionoptions-=options
set shiftround
set shortmess=aFIoOtT
set showcmd
set sidescroll=1
set sidescrolloff=5
set smarttab
set spellfile=~/.vim/spell/en.utf-8.add,~/.vim/spell/en-local.utf-8.add
set spelllang=en_us
set switchbuf=uselast
set tags+=./tags;
set thesaurus+=~/.vim/spell/mthesaur.txt
set timeoutlen=1200
set title
set ttimeout
set ttimeoutlen=50
set undodir^=~/.vim/_undo
set undofile
set viewoptions-=options
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
if exists('*FugitiveStatusline') | set statusline+=%{FugitiveStatusline()} | endif
set statusline+=%=                  " l-r separator
set statusline+=%-10.(0x%B%)        " hex value of character under cursor
set statusline+=%-15.(%l,%c%V%)\ %P " line#,col#-vcol# %

set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete

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
else
  set grepprg=grep\ -rnHI\ --exclude-dir=.git\ --exclude=tags
endif

" plugin settings
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
  \ 'javascript': ['eslint']
  \}
let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \}
let g:ale_pattern_options = {
  \ '/node_modules/': { 'ale_enabled': 0 },
  \ '\.go$': { 'ale_enabled': 0 },
  \}
let g:go_highlight_extra_types = 1
let g:html_indent_inctags = 'dd,dt,p'
let g:html_indent_script1 = 'inc'
let g:html_indent_style1  = 'inc'
let g:is_posix = 1
let g:markdown_fenced_languages = [
  \ 'bash=sh',
  \ 'css',
  \ 'go',
  \ 'html',
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

" mappings
let g:mapleader = ','

" make Q work like gq instead of switching to Ex mode
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

" make Ctrl-C check abbreviations, trigger InsertLeave, and preserve cursor
" position
inoremap <C-C> <Esc>`^

" continuous indentation
xnoremap > >gv
xnoremap < <gv

" clear search highlighting
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

function! s:sort_opfunc(...)
  '[,']sort
endfunction
nnoremap <silent> gs :set operatorfunc=<SID>sort_opfunc<CR>g@
xnoremap <silent> gs :sort<CR>

nnoremap <silent> gb :GBrowse<CR>
xnoremap <silent> gb :GBrowse<CR>

noremap gy "*y
noremap gY "*y$

nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap yol :setlocal invlist<CR>
nnoremap yow :setlocal invwrap<CR>

nnoremap <silent> cd
  \ :if exists('*FugitiveGitDir') && !empty(FugitiveGitDir())<Bar>
  \   Glcd<Bar>
  \ else<Bar>
  \   lcd %:h<Bar>
  \ endif<Bar>
  \ <CR>

nnoremap <silent> <C-W>z :wincmd z<Bar>pclose<Bar>cclose<Bar>lclose<Bar>helpclose<CR>

function! s:JumpToLastCursorPosition()
  " If the last position is unset or past the end of the file, do nothing.
  if line("'\"") == 0 || line("'\"") > line("$")
    return
  endif

  " Jump to the last cursor position. If it is not in the bottom half of the
  " last window, then re-center the window on the line.
  if line("$") - line("'\"") > (line("w$") - line("w0")) / 2
    return "g`\"zz"
  else
    return "g`\""
  endif
endfunction

nnoremap <expr> gl <SID>JumpToLastCursorPosition()

augroup vimrc
  autocmd!
  autocmd BufNewFile,BufReadPost *.log{,.[0-9]*} setlocal readonly bufhidden=unload buftype=nowrite noundofile nowrap
  autocmd BufNewFile,BufReadPost */node_modules/* setlocal readonly
  autocmd BufWritePost */spell/*.add silent! mkspell! <afile>
  autocmd BufWritePre /tmp/*,$TMPDIR/*,/{private,var,private/var}/tmp/*,/{var,private/var}/folders/* setlocal noundofile
  autocmd CursorHoldI * silent! call feedkeys("\<C-G>u", "nt")
  autocmd CursorHold,CursorHoldI,BufWritePost,BufReadPost,BufLeave *
    \ if !empty(filter(split(&directory, ","), "isdirectory(expand(v:val))")) |
    \   let &swapfile = &modified |
    \ endif
  autocmd FocusGained * silent! checktime
  autocmd FocusLost * silent! wall
augroup END

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
