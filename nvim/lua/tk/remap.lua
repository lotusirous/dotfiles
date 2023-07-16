local keymap = vim.keymap

-- Wonderful mapping
keymap.set("i", "<C-c>", "<esc>", { noremap = true })
vim.g.mapleader = " "

-- Keymap
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

--keymap.set("n", "<leader>gs", ":Git<CR>", { noremap = true })
-- keymap.set("n", "<leader>gs", ":Git<CR>", { noremap = true })
keymap.set("n", "<leader>gs", ":FloatermNew --height=0.95 --width=0.95 --name=lazygit lazygit<CR>")
keymap.set("n", "<leader>`", ":Marks<CR>", { noremap = true })
--keymap.set("n", "<C-p>", ":Files<CR>", { noremap = true })
keymap.set("n", "<leader>b", ":Buffers<CR>", { noremap = true })
keymap.set("n", "<C-p>", ":Files<CR>", { noremap = true })
keymap.set("n", "<leader>ps", ":Rg<CR>", { noremap = true })
keymap.set("n", "<leader>ft", ":Filetypes<CR>", { noremap = true })

-- Easier Moving between splits
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
keymap.set("n", "<C-,>", "<C-w>5>", { noremap = true })
keymap.set("n", "<C-.>", "<C-w>5<", { noremap = true })

keymap.set("v", "<Tab>", ">gv", { noremap = true })
keymap.set("v", "<S-Tab>", ">gv", { noremap = true })

-- Tagbar
keymap.set("n", "<F8>", ":TagbarToggle<CR>", { noremap = true })

-- Copy to system clipboard
keymap.set("n", "<leader>y", '"+y', { noremap = true })
keymap.set("v", "<leader>y", '"+y', { noremap = true })
keymap.set("n", "<leader>Y", 'gg"+yG', { noremap = true })

keymap.set("n", "<leader>m", ":NERDTreeFind<CR>", { noremap = true })
keymap.set("n", "<leader>r", ":NERDTreeRefreshRoot<CR>", { noremap = true })

-- paste image in markdown
