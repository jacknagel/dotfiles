if exists("g:loaded_plist") || &cp
  finish
else
  let g:loaded_plist = 1
endif

augroup plist
  autocmd!
  autocmd BufReadCmd *.plist call plist#read(1)
  autocmd FileReadCmd *.plist call plist#read(0)
  autocmd BufWriteCmd,FileWriteCmd *.plist call plist#write()
augroup END
