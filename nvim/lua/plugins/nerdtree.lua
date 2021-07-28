local function init()
    vim.g.nerdtreeshowlinenumbers = 1
    vim.cmd('autocmd filetype nerdtree setlocal relativenumber')
    vim.g.NERDTreeShowHidden = 1

    -- Movement 
    vim.api.nvim_set_keymap('n', '<leader>ne', ':NERDTreeToggle<CR>',
                            {noremap = true, silent = true})
end
return {init = init}
