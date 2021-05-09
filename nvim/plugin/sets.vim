set completeopt=menuone,noinsert,noselect

" General configuration options
set nocompatible " Use Vim settings, rather then Vi settings
set backspace=indent,eol,start " Allow backspacing over indention
set history=1000 " Set bigger history of executed commands
set autoread " Automatically re-read files if unmodified inside Vim
set hidden " Manage multiple buffers effectively


" User interface options
set title
set guicursor=
set relativenumber
set number
set cursorline
set visualbell " Flash screen instead of beep sound
set noerrorbells
set wildmenu "enables a menu at the bottom of the vim/gvim window
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Indentation options
set autoindent " New lines inherit the indentation of previous lines
filetype plugin indent on " Use this options instead of smartindent
set tabstop=4 softtabstop=4
set shiftwidth=2
set expandtab " On pressing tab, insert 4 spaces
set nowrap " Don't wrap the line

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Search options
set incsearch " Find next match as we type the search
"set hlsearch " Highlight searches by default or `nohlsearch`
set nohlsearch

"set
set ignorecase " Ignore case when searching
set smartcase " ...Unless you type a capital


" Swap and backup file options - disable all of them:
set noswapfile
set nobackup
set nowritebackup


" Text rendering
set encoding=utf-8
set linebreak " Wrap lines at convenient points
set scrolloff=3 " The number of screen lines to keep above and below the cursor
set sidescrolloff=5 " The number of screen columns to keep to the left and right
syntax on


" Undo options
set undodir=~/.vim/undodir
set undofile




" Miscellaneous Options
set confirm " Display a confirmation dialog when closing an unsaved file
"set spell
set spelllang=en_us

" use system clipboard. Make sure you have +clipboard in `vim --version`
" set clipboard=unnamed


" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

