# Vim plugin for shfmt

The **Vim shfmt** plugin runs [shfmt](https://github.com/mvdan/sh) to auto format the current buffer by a command `:Shfmt`.
If instead you prefer to format a textobject, say a paragraph, by `gq`, then add to the file `after/ftplugin/sh.vim` in your Vim configuration folder the lines

```vim
if executable('shfmt')
  let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -ln posix -sr -ci -s'
endif
```

and press, say `gqip`.
Customize the options ` -ln posix -sr -ci -s` to your liking.

## Requirements

You just need the **`shfmt`** command

## Installation

Obtain a copy of this plugin and place `shfmt.vim` in your Vim plugin directory or be sensible and use something like Plug:

```viml
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
```

## Usage

You can use the `:Shfmt` command to run shfmt and automatically format the current buffer

You can also use the `:Shfmt` command together with options. For example,

```
:Shfmt -p
```

```
:Shfmt -i 2
```

### Configuration

**shfmt** uses tabs by default for auto formatting, so if you prefer to use 2 spaces, you can set the following in your `.vimrc` file:

```viml
let g:shfmt_extra_args = '-i 2'
```

### Auto format on save

If you would like to auto format shell scripts on save, you can add the following to your vim config:

```viml
let g:shfmt_fmt_on_save = 1
```

## License

The Vim shfmt plugin is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
