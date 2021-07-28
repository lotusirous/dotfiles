local function init()
    vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>ps', ':Rg<CR>',
                            {noremap = true, silent = true})

    -- copy to clipboard
    -- vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<leader>Y', 'gg"+yG', { noremap = true, silent = true })
    vim.cmd('nnoremap <leader>y "+y')
    vim.cmd('vnoremap <leader>y "+y')
    vim.cmd('nnoremap <leader>Y gg"+yG')

    vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>',
                            {noremap = true, silent = true})

    -- windows navigation
    vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>',
                            {noremap = true, silent = true})
end

return {init = init}
