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

if has('terminal')
  tnoremap <expr> <F26> terminator#focus_lost()
  tnoremap <expr> <F27> terminator#focus_gained()
endif

nnoremap <silent> <F26> :silent doautocmd <nomodeline> FocusLost %<CR>
nnoremap <silent> <F27> :silent doautocmd <nomodeline> FocusGained %<CR>
onoremap <silent> <F26> <Esc>:silent doautocmd <nomodeline> FocusLost %<CR>
onoremap <silent> <F27> <Esc>:silent doautocmd <nomodeline> FocusGained %<CR>
vnoremap <silent> <F26> <Esc>:silent doautocmd <nomodeline> FocusLost %<CR>gv
vnoremap <silent> <F27> <Esc>:silent doautocmd <nomodeline> FocusGained %<CR>gv
inoremap <silent> <F26> <C-\><C-O>:silent doautocmd <nomodeline> FocusLost %<CR>
inoremap <silent> <F27> <C-\><C-O>:silent doautocmd <nomodeline> FocusGained %<CR>
