if exists("g:autoloaded_terminator") || &cp
  finish
else
  let g:autoloaded_terminator = 1
endif

function! terminator#focus_lost() abort
  let l:cmd = getcmdline()
  let l:pos = getcmdpos()

  silent doautocmd FocusLost %

  call setcmdpos(l:pos)
  return l:cmd
endfunction

function! terminator#focus_gained() abort
  let l:cmd = getcmdline()
  let l:pos = getcmdpos()

  silent doautocmd FocusGained %

  call setcmdpos(l:pos)
  return l:cmd
endfunction

function! terminator#paste(ret) abort
  set paste
  return a:ret
endfunction
