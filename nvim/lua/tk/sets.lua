vim.o.cursorline = true

-- Disable mouse support
vim.o.mouse = ''

-- Disable error bells and use visual bell
vim.o.errorbells = false
vim.o.visualbell = true

-- Set tabstop, softtabstop, and shiftwidth
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Use spaces instead of tabs
vim.o.expandtab = true

-- Enable smart indenting
vim.o.smartindent = true

-- Show line numbers and relative line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Disable line wrapping
vim.o.wrap = false

-- Disable swap, backup, and write backup files
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

-- Set undodir and enable undofile
vim.o.undodir = vim.env.HOME .. '/.config/nvim/undodir'
vim.o.undofile = true

-- Configure search options
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.smartcase = true

-- Save file when switching buffer
vim.o.hidden = true

-- Enable termguicolors
vim.o.termguicolors = true

-- Enable sign column for git
-- vim.wo.signcolumn = 'yes'
vim.wo.signcolumn = "yes:1"

-- Disable netrw and netrwPlugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable NERDTree minimal UI
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowLineNumbers = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinSize = 45

-- vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

-- Python host programs
vim.g.python_host_prog = vim.env.HOME .. '/.pyenv/versions/2.7.18/bin/python'
vim.g.python3_host_prog = vim.env.HOME .. '/.pyenv/versions/3.11.3/bin/python'
