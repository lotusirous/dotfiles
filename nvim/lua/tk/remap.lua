local keymap = vim.keymap

-- Wonderful mapping
keymap.set('i', '<C-c>', '<esc>', { noremap = true })
vim.g.mapleader = ' '

-- Keymap
keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true })
keymap.set('n', '<Leader>+', ':vertical resize +5<CR>', { noremap = true })
keymap.set('n', '<Leader>-', ':vertical resize -5<CR>', { noremap = true })

keymap.set('v', 'J', "'>+1<CR>gv=gv", { noremap = true })
keymap.set('v', 'K', "'<-2<CR>gv=gv", { noremap = true })

keymap.set('n', '<leader>b', ':Buffers<CR>', { noremap = true })
keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true })
keymap.set('n', '<leader>`', ':Marks<CR>', { noremap = true })
keymap.set('n', '<C-p>', ':Files<CR>', { noremap = true })
keymap.set('n', '<leader>ps', ':Rg<CR>', { noremap = true })

-- Tagbar
keymap.set('n', '<F8>', ':TagbarToggle<CR>', { noremap = true })

-- Copy to system clipboard
keymap.set('n', '<leader>y', '"+y', { noremap = true })
keymap.set('v', '<leader>y', '"+y', { noremap = true })
keymap.set('n', '<leader>Y', 'gg"+yG', { noremap = true })

keymap.set('n', '<leader>n', ':NERDTreeToggle<CR>', { noremap = true })
keymap.set('n', '<leader>m', ':NERDTreeFind<CR>', { noremap = true })
keymap.set('n', '<leader>r', ':NERDTreeRefreshRoot<CR>', { noremap = true })
