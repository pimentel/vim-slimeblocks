" if exists('g:loaded_slimeblocks') || &cp || v:version < 700
"   finish
" endif
" let g:loaded_slimeblocks = 1

let g:SlimeBlocksVerbose = 1

function! s:SlimeBlocksFunctionGeneric()
  echoerr "slimeblocks: filetype not recognized"
endfunction

function! s:SlimeBlocksFencedGeneric()
  echom "test..."
  let save_cursor=winsaveview()
  let i = line('.')
  let line = getline(i)
  while i > 0 && line !~ '^```'
    let i -= 1
    let line = getline(i)
  endwhile
  if i == 0
    echom "start of fenced block not found"
    return
  endif
  let start_of_function = i
  let start_of_function += 1

  let i += 1
  let line = getline(i)
  let end = line('$') + 1
  while i < end && line !~ '^```'
    let i += 1
    let line = getline(i)
  endwhile

  if i == end
    echom "end of fenced block not found"
    return
  endif
  let end_of_function = i
  let end_of_function -= 1

  if g:SlimeBlocksVerbose
    echom "SlimeBlocksFenced (" . start_of_function . ", " . end_of_function . ")"
  endif

  let cursor_row = save_cursor.lnum

  if !(start_of_function <= cursor_row && cursor_row <= end_of_function)
    echoerr "SlimeBlocksFenced: not within fenced block range"
    return
  endif

  :exe start_of_function . "," . end_of_function "SlimeSend"

  call winrestview(save_cursor)
endfunction

autocmd BufRead,BufNewFile *
    \ if !exists('b:SlimeBlocksFunction') |
    \   let b:SlimeBlocksFunction = function('<SID>SlimeBlocksFunctionGeneric') |
    \ endif

autocmd BufRead,BufNewFile *
    \ if !exists('b:SlimeBlocksFenced') |
    \   let b:SlimeBlocksFenced = function('<SID>SlimeBlocksFencedGeneric') |
    \ endif
