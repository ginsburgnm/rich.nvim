# Rich.nvim

A [rich-cli](https://github.com/Textualize/rich-cli) preview directly in your
neovim buffer.

## Prerequisites

- Neovim 0.5 or higher

## Installing

with [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'ginsburgnm/rich.nvim'
```

with [packer.nvim](https://github.com/wbthomason/packer.nvim)

```viml
use {"ginsburgnm/rich.nvim"}
```

## Configuration

- `rich_path`

Use `g:rich_path` for vimscript config or `vim.g.rich_path` for lua config.

If set, this path will be used to execute `rich`. Otherwise rely on `$PATH`.

If `rich` is not on `$PATH` or `rich__path` is set and `rich` is not found
the popup will return this error

Example:

```viml
let g:rich_path = "~/venv/bin/rich"
```

```lua
vim.g.rich_border = "~/venv/bin/rich"
```

- `rich_border`

Use `g:rich_border` for vimscript config or `vim.g.rich_border` for lua config.

If set, this will change the border of the window. Type `:help nvim_open_win`
for border options.

Example:

```viml
let g:rich_border = "rounded"
```

```lua
vim.g.rich_border = "rounded"
```

- `rich_width`

Use `g:rich_width` for vimscript config or `vim.g.rich_width` for lua config.

If set, this will change the width of the window.

Example:

```viml
let g:rich_width = 120
```

```lua
vim.g.rich_width = 120
```

- `rich_style`

Use `g:rich_style` for vimscript config or `vim.g.rich_style` for lua config.

If set this will change the theme used by rich (all pygments names should work)
default is `material`

Example:

```viml
let g:glow_style = "dracula"
```

```lua
vim.g.glow_style = "dracula"
```

## Usage

```viml
:Rich [path-to-md-file]
```

- Pressing `q` will automatically close the window
- No path arg means rich uses current path in vim
- `:Rich` command will work as toggle feature, so calling it will open or close
the current preview

You can also create a mapping getting a preview of the current file

```viml
noremap <leader>p :Rich<CR>
```

For users who want to make rich.nvim buffer fullscreen, there's a native vim keybinding

- `Ctrl-w + |` set window's width max
- `Ctrl-w + _` set window's height max

Or you can have a fullscreen option by creating a mapping for setting both
window's height and width max at once

```viml
noremap <C-w>z <C-w>\|<C-w>\_
```

### Credits

This was HEAVILY influenced by [glow.nvim](https://github.com/ellisonleao/glow.nvim)
to the point where most of the code (and even this readme) is copy paste, then find-rename.

Some of the configs I haven't actually tested but it looked like they were parameters
to the neovim buffer windows so it should just work.
