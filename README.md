# slime blocks

This is a Vim plugin that adds basic functionality to send file type specific blocks (e.g. functions)
to a REPL.

This project is very alpha and basically only built to suit my needs.

# Installation

Depends on [vim-slime](https://github.com/jpalardy/vim-slime).
If you are using [vim-plug](https://github.com/junegunn/vim-plug) as your package manager, put this in you `.vimrc`:

```
Plug 'jpalardy/vim-slime'
Plug 'pimentel/vim-slimeblocks'
```

# mapping

Suggested mapping in normal mode:

```vim
noremap <Leader><Leader>f :call b:SlimeBlocksFunction()<cr>
```

## configuration

By default, the following will output a message when sending a block:

```
let g:SlimeBlocksVerbose = 1
```

## functions

- `b:SlimeBlocksFunction()` searches backwards starting at the current line for a function. The code is then sent to your REPL using `:SlimeSend`.

## R support

### `b:SlimeBlocksFunction()`

Recognized functions start like this:

```r
function_name123 <- function(...)
```

Assignment can be done via `<-` or `=`.

The end of a function is denoted by beginning of a line with `}`.

## python support

### `b:SlimeBlocksFunction()`

Recognized functions start like this:

```python
def function_name123(...)
```

After finding the beginning, it looks for the end defined by a non-comment character in the first column.
It then backtracks to find the first indented line.

