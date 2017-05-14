setlocal autoindent
setlocal expandtab
setlocal shiftwidth=2

let s:formatprg = findfile('node_modules/.bin/prettier-eslint', '.;')
if !executable(s:formatprg)
  let s:formatprg = exepath('prettier-eslint')
endif
let &l:formatprg = s:formatprg . ' --stdin'

let b:surround_{char2nr("$")} = "$(\r)"
