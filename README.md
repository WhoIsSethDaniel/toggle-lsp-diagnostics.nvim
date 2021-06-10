# Description
A Neovim plugin for toggling the LSP diagnostics. Turn all diagnostics on/off or turn on/off
individual features of diagnostics (virtual text, underline, signs, etc...).

<img src="https://github.com/WhoIsSethDaniel/public-assets/blob/main/toggle-diag-onoff.gif" height="680" width="600">

# Compatibility
Neovim >= 0.5.0

# Installation
Install using your favorite plugin manager. 

If you use vim-plug:
```vim
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
```
Or if you use Vim 8 style packages:
```
cd <plugin dir>
git clone https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
```

# Configuration
Somwhere in your config you should have this:
```lua
require'toggle_lsp_diagnostics'.init()
```
If you are using Vimscript for configuration:
```vim
lua <<EOF
require'toggle_lsp_diagnostics'.init()
EOF
```

# Behavior
The toggling is currently done globally. When you turn off all diagnostics you do so for
all buffers / clients both now and in the future. When you turn diagnostics back on the 
same applies.

If you toggle off certain features, such as signs, this does not mean that it will turn 
back on if you toggle all diagnostics to on. The global on toggling is separate from
the individual feature toggling. Turning all diagnostics off will turn all diagnostics off
regardless of state. You cannot then individually turn on diagnostic features. You must 
turn on diagnostics and toggle off features.

# Mappings
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
Toggle all diagnostics. Turn them all off / on

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
nmap <leader>tldo <Plug>(toggle-lsp-diag-off)
nmap <leader>tldf <Plug>(toggle-lsp-diag-on)
```

# Commands
The following commands are available:

`:ToggleDiag`
Toggle all diagnostics on/off

`:ToggleDiagOn`
Turn ALL diagnostics on.

`:ToggleDiagOff`
Turn ALL diagnostics off.
