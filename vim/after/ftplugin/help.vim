setlocal keywordprg=:help

let &l:path = escape(&runtimepath, ' ')

nnoremap <silent> <buffer> q :<C-U>q<CR>
