" if exists('g:loaded_slimeblocks') || &cp || v:version < 700
"   finish
" endif
" let g:loaded_slimeblocks = 1

let g:SlimeBlocksVerbose = 1

function! s:SlimeBlocksFunctionGeneric()
  echoerr "slimeblocks: filetype not recognized"
endfunction

autocmd BufRead,BufNewFile *
    \ if !exists('b:SlimeBlocksFunction') |
    \   let b:SlimeBlocksFunction = function('<SID>SlimeBlocksFunctionGeneric') |
    \ endif
