if exists('g:toggle_lsp_diagnostics_loaded_install')
  finish
endif
let g:toggle_lsp_diagnostics_loaded_install = 1

let s:cpo_save = &cpo
set cpo&vim

nnoremap <silent> <Plug>(toggle-lsp-diag-underline) <cmd>lua require'toggle_lsp_diagnostics'.toggle_underline()<CR>
nnoremap <silent> <Plug>(toggle-lsp-diag-signs) <cmd>lua require'toggle_lsp_diagnostics'.toggle_signs()<CR>
nnoremap <silent> <Plug>(toggle-lsp-diag-vtext) <cmd>lua require'toggle_lsp_diagnostics'.toggle_virtual_text()<CR>
nnoremap <silent> <Plug>(toggle-lsp-diag-update_in_insert) <cmd>lua require'toggle_lsp_diagnostics'.toggle_update_in_insert()<CR>

nnoremap <silent> <Plug>(toggle-lsp-diag-default) <cmd>lua require'toggle_lsp_diagnostics'.turn_on_default_diagnostics()<CR>
nnoremap <silent> <Plug>(toggle-lsp-diag) <cmd>lua require'toggle_lsp_diagnostics'.toggle_diagnostics()<CR>
nnoremap <silent> <Plug>(toggle-lsp-diag-off) <cmd>lua require'toggle_lsp_diagnostics'.turn_off_diagnostics()<CR>
nnoremap <silent> <Plug>(toggle-lsp-diag-on) <cmd>lua require'toggle_lsp_diagnostics'.turn_on_diagnostics()<CR>

command! -nargs=0 ToggleDiag lua require'toggle_lsp_diagnostics'.toggle_diagnostics()
command! -nargs=0 ToggleDiagDefault lua require'toggle_lsp_diagnostics'.turn_on_diagnostics_default()
command! -nargs=0 ToggleDiagOn lua require'toggle_lsp_diagnostics'.turn_on_diagnostics()
command! -nargs=0 ToggleDiagOff lua require'toggle_lsp_diagnostics'.turn_off_diagnostics()

let &cpo = s:cpo_save
unlet s:cpo_save
