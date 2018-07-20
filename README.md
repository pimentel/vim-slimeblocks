# slime blocks

This is a Vim plugin that adds basic functionality to send file type specific blocks (e.g. functions)
to a REPL.

This project is very alpha and basically only built to suit my needs.

Current support:

- R

Planned support:

- python

## mapping

So far the only functionality is sending a function.
Suggested mapping in normal mode:

```vimscript
noremap <Leader><Leader>f :call b:SlimeBlocksFunction()
```
