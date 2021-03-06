function! python#slimeblocks#SlimeBlocksFunction()
  let save_cursor=winsaveview()
  call winrestview(save_cursor)
  let i = line('.')
  let line = getline(i)
  while i > 0 && line !~ '^def[[:space:]]\+[a-zA-Z]\+[a-zA-Z0-9]*[[:space:]]*'
    let i -= 1
    let line = getline(i)
  endwhile
  if i == 0
    echom "start of python function not found"
    return
  endif
  let start_of_function = i

  let i += 1
  let line = getline(i)
  let end = line('$') + 1
  while i < end && line !~ '^[^# ]'
    let i += 1
    let line = getline(i)
  endwhile

  let tmp_end_of_function = i
  while i > start_of_function && line !~ '^\s\+\S'
    let i -= 1
    let line = getline(i)
  endwhile
  let end_of_function = i

  if g:SlimeBlocksVerbose
    echom "SlimeBlocksFunction (" . start_of_function . ", " . end_of_function . ")"
  endif

  let cursor_row = save_cursor.lnum

  if !(start_of_function <= cursor_row && cursor_row <= end_of_function)
    echoerr "SlimeBlocksFunction: not within function range"
    return
  endif

  :exe start_of_function . "," . end_of_function "SlimeSend"

  call winrestview(save_cursor)
endfunction

let b:SlimeBlocksFunction = function('python#slimeblocks#SlimeBlocksFunction')
