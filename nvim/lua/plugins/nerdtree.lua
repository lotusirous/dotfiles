function init() 
  vim.g.nerdtreeshowlinenumbers = 1
  vim.cmd('autocmd filetype nerdtree setlocal relativenumber')
end
return {
  init=init,
}
