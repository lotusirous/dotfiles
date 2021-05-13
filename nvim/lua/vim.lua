local function set_vim_g()
    vim.g.mapleader = " "
    -- disable netrw by default
    vim.g.loaded_netrwPlugin = false
end

local function set_vim_o()
    local settings = {
        backup = false,
        errorbells = false,
        expandtab = true,
        hidden = true,
        scrolloff = 3,
        softtabstop = 2,
        showmode = false,
        termguicolors = true
    }

    -- Generic vim.o
    for k, v in pairs(settings) do vim.o[k] = v end

    -- Custom vim.o
    vim.o.shortmess = vim.o.shortmess .. 'c'

    -- UI options
    vim.cmd('set nocompatible') -- Use Vim settings, rather then Vi settings
    vim.cmd('set backspace=indent,eol,start') -- Allow backspacing over indention
    vim.cmd('set history=1000') -- Set bigger history of executed commands
    vim.cmd('set autoread') -- Automatically re-read files if unmodified inside Vim
    vim.cmd('set hidden') -- Manage multiple buffers effectively

    vim.cmd('set title')
    vim.cmd('set guicursor= ')
    vim.cmd('set cursorline')
    vim.cmd('set visualbell') -- Flash screen instead of beep sound
    vim.cmd('set noerrorbells')
    vim.cmd('set colorcolumn=80')
    vim.cmd('highlight ColorColumn ctermbg=0 guibg=lightgrey')

    -- Indentation options
    vim.cmd('set autoindent') -- New lines inherit the indentation of previous lines
    vim.cmd('filetype plugin indent on') -- Use this options instead of smartindent
    vim.cmd('set tabstop=4 softtabstop=4')
    vim.cmd('set shiftwidth=2')
    vim.cmd('set expandtab') -- On pressing tab, insert 4 spaces
    vim.cmd('set nowrap') -- Don't wrap the line

    -- for python and go
    vim.cmd(
        'autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4')
    vim.cmd('autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4')

    -- Search options
    vim.cmd('set ignorecase') -- Ignore case when searching
    vim.cmd('set smartcase') -- ...Unless you type a capital
    vim.cmd('set incsearch')
    vim.cmd('set nohlsearch')

    -- text rendering
    vim.cmd('set encoding=utf8')
    vim.cmd('set linebreak') -- Wrap lines at convenient points
    vim.cmd('set scrolloff=3') -- The number of screen lines to keep above and below the cursor
    vim.cmd('set sidescrolloff=5') -- The number of screen columns to keep to the left and right

    -- Swap and backup file options - disable all of them
    vim.cmd('set noswapfile')
    vim.cmd('set nobackup')
    vim.cmd('set nowritebackup')

    -- undo options
    vim.cmd('set undodir=~/.vim/undodir')
    vim.cmd('set undofile')

    -- Give more space for displaying messages.
    vim.cmd('set cmdheight=2')

    -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    -- delays and poor user experience.
    vim.cmd('set updatetime=50')

    -- Don't pass messages to |ins-completion-menu|.
    vim.cmd('set shortmess+=c')

end

local function set_vim_wo()
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.wo.wrap = false
end

local function init()
    set_vim_g()
    set_vim_o()
    set_vim_wo()
end

return {init = init}
