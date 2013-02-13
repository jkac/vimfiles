
function! RedirM2Output()

  let filename= expand('%:p')

  if( match( filename, "-output" ) != -1)
    return
  endif

  if( match( filename, "m2" == -1)
    return
  endif

  let a:newtab= expand('%:p')."-output"
  tabnext
  if( expand('%:p') != a:newtab )
    tabprevious
    exec "tabnew".a:newtab
  else
    exec "%d"
  endif

  exec 'select r !M2 --script '.filename
  set nomodified
endfunc

noremap <F6> :call RedirM2Output()<CR>
