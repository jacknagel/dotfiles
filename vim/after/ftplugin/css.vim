setlocal autoindent
setlocal expandtab
setlocal iskeyword+=-
setlocal shiftwidth=2

let s:formatprg = findfile('node_modules/.bin/stylefmt', '.;')
if !executable(s:formatprg)
  let s:formatprg = exepath('stylefmt')
endif
let &l:formatprg = s:formatprg . ' --stdin-filename ' . expand('%:p')
