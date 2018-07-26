# slime blocks

This is a Vim plugin that adds basic functionality to send file type specific blocks (e.g. functions)
to a REPL.

This project is very alpha and basically only built to suit my needs.

# installation

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
noremap <Leader><Leader>m :call b:SlimeBlocksFenced()<cr>
```

# configuration

By default, the following will output a message when sending a block:

```
let g:SlimeBlocksVerbose = 1
```

# markdown support

- `b:SlimeBlocksFenced()` searches for a Markdown-style fenced block in all files.

## known issues

- If you are in between blocks, it will send the text in between. This is because it simply looks backwards then forwards for backticks. This can be fixed by requiring fully qualified Markdown blocks (e.g. containing the language type) but I don't want to be that strict. Just don't call the function between blocks...

# functions

- `b:SlimeBlocksFunction()` searches backwards starting at the current line for a function. The code is then sent to your REPL using `:SlimeSend`. It also requires you to be within the function block.

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

