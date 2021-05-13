local function init()
  vim.cmd("let g:syntastic_go_checkers = ['golint', 'govet', 'golangci-lint']")
  vim.cmd("let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']")
  vim.cmd("let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }")
  -- default format command
  vim.cmd("let g:go_fmt_command = 'goimports'")

  vim.cmd("let g:go_info_mode='gopls'")

  vim.cmd("let g:go_code_completion_enabled = 0") -- this will be done by lsp
  vim.cmd("set omnifunc=") -- this will be done by lsp

  vim.cmd("let g:go_highlight_types = 1")
  vim.cmd("let g:go_highlight_fields = 1")
  vim.cmd("let g:go_highlight_functions = 1")
  vim.cmd("let g:go_highlight_function_calls = 1")
  vim.cmd("let g:go_highlight_operators = 1")
  vim.cmd("let g:go_highlight_extra_types = 1")
  vim.cmd("let g:go_highlight_build_constraints = 1")
  vim.cmd("let g:go_highlight_generate_tags = 1")

  -- Manage unit tests in the current file
  vim.cmd("autocmd BufEnter *.go nmap <leader>t  <Plug>(go-test)")
  vim.cmd("autocmd BufEnter *.go nmap <leader>tt <Plug>(go-test-func)")
  vim.cmd("autocmd BufEnter *.go nmap <leader>tc  <Plug>(go-coverage-toggle)")
  -- inspect code base
  vim.cmd("autocmd BufEnter *.go nmap <leader>i  <Plug>(go-info)")
  vim.cmd("autocmd BufEnter *.go nmap <leader>ii  <Plug>(go-implements)")
  vim.cmd("autocmd BufEnter *.go nmap <leader>ci  <Plug>(go-describe)")
  vim.cmd("autocmd BufEnter *.go nmap <leader>cc  <Plug>(go-callers)")
end

return {
  init=init,
}
