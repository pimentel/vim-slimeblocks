function! r#slimeblocks#SlimeBlocksFunction()
" function! s:RSlimeBlocksFunction()
  let save_cursor=winsaveview()
  let i = line('.')
  let line = getline(i)
  while i > 0 && line !~ '[a-zA-Z]\+[a-zA-Z0-9_\.]*[[:space:]]*\(<-\|=\)[[:space:]]*\(function\)[[:space:]]*\((\)'
    let i -= 1
    let line = getline(i)
  endwhile
  if i == 0
    echom "start of R function not found"
    return
  endif
  let start_of_function = i

  let line = getline(i)
  let end = line('$') + 1
  while i < end && line !~ '^\(}\)'
    let i += 1
    let line = getline(i)
  endwhile

  if i == end
    echom "end of R function not found"
    return
  endif
  let end_of_function = i

  if g:SlimeBlocksVerbose
    echom "SlimeBlocksFunction (" . start_of_function . ", " . end_of_function . ")"
  endif

  :exe start_of_function . "," . end_of_function "SlimeSend"

  call winrestview(save_cursor)
endfunction

let b:SlimeBlocksFunction = function('r#slimeblocks#SlimeBlocksFunction')
" let b:SlimeBlocksFunction = function('<SID>RSlimeBlocksFunction')
