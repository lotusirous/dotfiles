syntax on

set guicursor=
set relativenumber
set nohlsearch
set hidden
"set spell
"set spelllang=en_us
set noerrorbells
set tabstop=4 softtabstop=4
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
set shiftwidth=4
set expandtab
"set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set completeopt=menuone,noinsert,noselect
" use system clipboard. Make sure you have +clipboard in `vim --version`
set clipboard=unnamed

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction


" Convert to cammelCase to snake_case
function ToSnakeCase()
  %s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g
  ''
endfunction


autocmd BufWritePre * call TrimWhiteSpace()


call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'

Plug 'itchyny/lightline.vim'

Plug 'preservim/nerdtree'
Plug 'ThePrimeagen/vim-be-good'
Plug 'junegunn/vim-easy-align'
Plug 'tweekmonster/gofmt.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'luochen1990/rainbow'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'mattn/vim-goimports'

call plug#end()

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle


colorscheme gruvbox
set background=dark


" faster searching from root
if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25


" Flash screen instead of beep sound
set visualbell

" --- vim go (polyglot) settings.
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

au filetype go inoremap <buffer> . .<C-x><C-o>


" file browsing
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" custom leader key
let loaded_matchparen = 1
let mapleader = " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>ps :Rg<CR>
