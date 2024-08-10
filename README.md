# ARCHIVED

This plugin has been archived. There isn't much reason for this plugin anymore.
Toggling the diagnostics for all buffers is made very simple by the current Lua
API. e.g. what I currently use to toggle all diagnostics on/off is this:

```lua
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })
```

# Description

A Neovim plugin for toggling the LSP diagnostics. Turn all diagnostics on/off or turn on/off
individual features of diagnostics (virtual text, underline, signs, etc...).

<img src="https://github.com/WhoIsSethDaniel/public-assets/blob/main/toggle-diag-on-off-2.gif">

## Compatibility

Neovim >= 0.5.0

## Installation

Install using your favorite plugin manager.

If you use vim-plug:

```vim
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
```

Or if you use Vim 8 style packages:

```bash
cd <plugin dir>
git clone https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
```

## Configuration

Somwhere in your config you should have this:

```lua
require('toggle_lsp_diagnostics').init()
```

If you are using Vimscript for configuration:

```vim
lua <<EOF
require'toggle_lsp_diagnostics'.init()
EOF
```

To preserve the current diagnostic configuration upon initializing this module you can do the following (assuming your
Neovim is at least 0.7):

```lua
vim.diagnostic.config { ...some config... }
require('toggle_lsp_diagnostics').init(vim.diagnostic.config())
```

You can pass an initial configuration for each of the diagnostic settings:

```lua
require('toggle_lsp_diagnostics').init { underline = false, virtual_text = { prefix = 'XXX', spacing = 5 } }
```

The above turns off underlining by default and configures the virtual text with a prefix of 'XXX' and five
spaces prior to the virtual text being printed. The complete list of settings may be found in lsp help
page.

You can configure diagnostics so that they are off when you first start Neovim:

```lua
require('toggle_lsp_diagnostics').init { start_on = false }
```

Simply toggle them back on when you want to see them.

## Behavior

The toggling is currently done globally. When you turn off all diagnostics you do so for
all buffers / clients both now and in the future. When you turn diagnostics back on the
same applies.

You can change the default settings by passing a configuration to the init() method (see the
'Configuration' section above).

## Mappings

The following mappings are available.

`<Plug>(toggle-lsp-diag-underline)`
Toggle underlining diagnostic information.

`<Plug>(toggle-lsp-diag-signs)`
Toggle displaying signs in the sign column.

`<Plug>(toggle-lsp-diag-vtext)`
Toggle displaying virtual text in your code.

`<Plug>(toggle-lsp-diag-update_in_insert)`
Toggle updating diagnostic information while in insert mode.

`<Plug>(toggle-lsp-diag)`
Toggle all diagnostics. Turn them all off / or back to what was passed to init().

`<Plug>(toggle-lsp-diag-default)`
Set all diagnostics to their default. The default is everything is on, unless other values were
passed to init().

`<Plug>(toggle-lsp-diag-on)`
Turn all diagnostics on.

`<Plug>(toggle-lsp-diag-off)`
Turn all diagnostics off.

An example configuration:

```vim
nmap <leader>tlu <Plug>(toggle-lsp-diag-underline)
nmap <leader>tls <Plug>(toggle-lsp-diag-signs)
nmap <leader>tlv <Plug>(toggle-lsp-diag-vtext)
nmap <leader>tlp <Plug>(toggle-lsp-diag-update_in_insert)

nmap <leader>tld  <Plug>(toggle-lsp-diag)
nmap <leader>tldd <Plug>(toggle-lsp-diag-default)
nmap <leader>tldo <Plug>(toggle-lsp-diag-off)
nmap <leader>tldf <Plug>(toggle-lsp-diag-on)
```

## Commands

The following commands are available:

`:ToggleDiag`
Toggle ALL diagnostics on/off

`:ToggleDiagDefault`
Toggle ALL diagnostics to their default

`:ToggleDiagOn`
Turn ALL diagnostics on

`:ToggleDiagOff`
Turn ALL diagnostics off
