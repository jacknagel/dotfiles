if exists("g:autoloaded_plist") || &cp
  finish
else
  let g:autoloaded_plist = 1
endif

function! plist#read(bufread) abort
  let filename = expand("<afile>")

  if !filereadable(filename)
    silent execute 'doautocmd BufNewFile ' . fnameescape(filename)
    return
  endif

  execute 'silent read !plutil -convert xml1 -o - ' . shellescape(filename, 1)

  if a:bufread
    keepjumps silent! 1d
  endif

  set filetype=xml

  if v:shell_error
    echoerr 'Unable to read or convert ' . filename

    if a:bufread
      silent bwipeout!
    endif

    return
  endif

  let content = readfile(filename, 1, 1)

  if len(content) == 0
    let b:plist_fmt = 'xml1'
  elseif content[0] =~ '^bplist'
    let b:plist_fmt = 'binary1'
  elseif content[0] =~ '^<?xml'
    let b:plist_fmt = 'xml1'
  else
    let b:plist_fmt = 'json'
  endif
endfunction

function! plist#write() abort
  let filename = expand("<afile>")

  execute "silent '[,']write !plutil -convert " . b:plist_fmt . ' - -o ' . shellescape(filename, 1)

  if v:shell_error
    echoerr 'Unable to write ' . filename
    return
  endif

  setlocal nomodified
endfunction
