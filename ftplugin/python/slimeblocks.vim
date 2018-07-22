function! python#slimeblocks#RSlimeBlocksFunction()
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

  :exe start_of_function . "," . end_of_function "SlimeSend"

endfunction

let b:SlimeBlocksFunction = function('python#slimeblocks#RSlimeBlocksFunction')
