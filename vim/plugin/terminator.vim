if exists("g:loaded_terminator") || &cp
  finish
else
  let g:loaded_terminator = 1
endif

let &t_ti .= "\<Esc>[?1004h"
let &t_te  = "\<Esc>[?1004l" . &t_te

execute "set <F26>=\<Esc>[O"
execute "set <F27>=\<Esc>[I"

cnoremap <silent> <F26> <C-\>eterminator#focus_lost()<CR>
cnoremap <silent> <F27> <C-\>eterminator#focus_gained()<CR>

if v:version >= 704
  nnoremap <silent> <F26> :silent doautocmd <nomodeline> FocusLost %<CR>
  nnoremap <silent> <F27> :silent doautocmd <nomodeline> FocusGained %<CR>
  onoremap <silent> <F26> <Esc>:silent doautocmd <nomodeline> FocusLost %<CR>
  onoremap <silent> <F27> <Esc>:silent doautocmd <nomodeline> FocusGained %<CR>
  vnoremap <silent> <F26> <Esc>:silent doautocmd <nomodeline> FocusLost %<CR>gv
  vnoremap <silent> <F27> <Esc>:silent doautocmd <nomodeline> FocusGained %<CR>gv
  inoremap <silent> <F26> <C-O>:silent doautocmd <nomodeline> FocusLost %<CR>
  inoremap <silent> <F27> <C-O>:silent doautocmd <nomodeline> FocusGained %<CR>
else
  nnoremap <silent> <F26> :silent doautocmd FocusLost %<CR>
  nnoremap <silent> <F27> :silent doautocmd FocusGained %<CR>
  onoremap <silent> <F26> <Esc>:silent doautocmd FocusLost %<CR>
  onoremap <silent> <F27> <Esc>:silent doautocmd FocusGained %<CR>
  vnoremap <silent> <F26> <Esc>:silent doautocmd FocusLost %<CR>gv
  vnoremap <silent> <F27> <Esc>:silent doautocmd FocusGained %<CR>gv
  inoremap <silent> <F26> <C-O>:silent doautocmd FocusLost %<CR>
  inoremap <silent> <F27> <C-O>:silent doautocmd FocusGained %<CR>
endif

let &t_ti .= "\<Esc>[?2004h"
let &t_te = "\<Esc>[?2004l" . &t_te

execute "set <F28>=\<Esc>[200~"
execute "set <F29>=\<Esc>[201~"

set pastetoggle=<F29>
cnoremap <F28> <Nop>
cnoremap <F29> <Nop>
nnoremap <expr> <F28> terminator#paste("i")
vnoremap <expr> <F28> terminator#paste("c")
inoremap <expr> <F28> terminator#paste("")
