syntax on

set guicursor=
set cursorline

set noerrorbells
set visualbell " Flash screen instead of beep sound

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set rnu
set nowrap

set noswapfile
set nobackup
set nowritebackup

set undodir=~/.vim/undodir
set undofile
"
" search options
set ignorecase
set incsearch
set nohlsearch
set smartcase " unless you type in capitalize

set hidden "Manage multiple buffers effectively
set termguicolors
set signcolumn=yes " for git


set completeopt=menuone,noselect


set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Give more space for displaying messages.
set cmdheight=1

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c



call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'



Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'windwp/nvim-autopairs'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'

Plug 'dkarter/bullets.vim'
Plug 'vim-utils/vim-man'


Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'SirVer/ultisnips'
Plug 'norcalli/snippets.nvim'


Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'


Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'


" Breaking bad habit
Plug 'takac/vim-hardtime'

" Read RFC
Plug 'mhinz/vim-rfc'


call plug#end()


colorscheme gruvbox
set background=dark
" transparent bg
hi Normal guibg=NONE ctermbg=NONE 


" add LSP config
lua require('lsp')

if executable('rg')
    let g:rg_derive_root='true'
endif


" Wonderfull mapping
let mapleader = " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

nnoremap <C-p> :Files<CR>
nnoremap <leader>ps :Rg<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG



" Compe completion
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:false
let g:compe.source.emoji = v:false


" Since I'm using nerdtree, i dont' need netrw at all.
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" NERDTREE option
let NERDTreeMinimalUI=1



" Enable hard time mode
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1

