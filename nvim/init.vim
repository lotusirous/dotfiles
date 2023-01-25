syntax on

set cursorline
"set guicursor=


" neovim 0.8 enable the mouse by default which is bad
set mouse=


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

set undodir=~/.config/nvim/undodir
set undofile
"
" search options
set ignorecase
set incsearch
set nohlsearch
set smartcase " unless you type in capitalize

set hidden " Save file when switching buffer
set termguicolors
set signcolumn=yes " for git



set inccommand=split

" unfold by default
set foldlevelstart=99


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

Plug 'gruvbox-community/gruvbox'
"Plug 'nvim-lualine/lualine.nvim'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
"Plug 'mengelbrecht/lightline-bufferline'
Plug 'mbbill/undotree'
Plug 'windwp/nvim-autopairs'
"Plug 'tpope/vim-vinegar'


Plug 'preservim/nerdtree'

" Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/tagbar'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-projectionist'
" Plug 'tpope/vim-sleuth' " better indent
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/vim-sonictemplate'


" Markdown
Plug 'dkarter/bullets.vim'


Plug 'neovim/nvim-lspconfig'

Plug 'lukas-reineke/lsp-format.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'saadparwaiz1/cmp_luasnip'


"Plug 'nvim-lua/plenary.nvim'

"Plug 'jose-elias-alvarez/null-ls.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-file-browser.nvim'

"Plug 'bling/vim-bufferline'


" Snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'


" Go development
Plug 'buoto/gotests-vim'
Plug 'rhysd/vim-go-impl'
Plug 'mattn/vim-goaddtags'
Plug 'ericpubu/lsp_codelens_extensions.nvim'

" Rust
Plug 'rust-lang/rust.vim'


" Python development
Plug 'heavenshell/vim-pydocstring'

" Breaking bad habit
Plug 'takac/vim-hardtime'


call plug#end()

" https://www.youtube.com/watch?v=-3S4xVDpLzI
set completeopt=menuone,noinsert,noselect

colorscheme gruvbox
set background=dark
" transparent bg
hi Normal guibg=NONE ctermbg=NONE


autocmd FileType markdown set list
autocmd FileType markdown set lcs=tab:→\
" hi NonText ctermfg=59   guifg=#282828
" hi SpecialKey ctermfg=59   guifg=#282828

" Status line
set laststatus=2
"set showtabline=2
let g:lightline = {}
let g:lightline.colorscheme = "gruvbox"
" let g:lightline#bufferline#show_number  = 1
" let g:lightline#bufferline#shorten_path = 0
" let g:lightline#bufferline#unnamed      = '[No Name]'
" let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
" let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
" let g:lightline.component_type   = {'buffers': 'tabsel'}
"let g:lightline#bufferline#number_separator = "|"


" Lua modules
lua require('tk.init')


if executable('rg')
    let g:rg_derive_root='true'
endif

" NerdTree options
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" The minimal UI has a bug: https://github.com/preservim/nerdtree/issues/1321
" This requires a hot fix locally: https://github.com/preservim/nerdtree/pull/1322/files
let NERDTreeMinimalUI=1
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=45







" LuaSnip
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'


" use this function by :call EmptyRegisters()
fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

" Wonderful mapping
inoremap <C-c> <esc>
let mapleader = " "

" Keymap
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>` :Marks<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>ps :Rg<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG


nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeFind<CR>
nnoremap <leader>r :NERDTreeRefreshRoot<CR>

" Template
let g:sonictemplate_vim_template_dir = expand('~/.config/nvim/templates')


" EasyAlign the code
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters[';'] = { 'pattern': ';', 'ignore_groups': ['String'] }


"vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Enable hard time mode
let g:hardtime_default_on = 0
let g:hardtime_showmsg = 0


" Required environment for many plugins
let g:python_host_prog="~/.pyenv/versions/2.7.18/bin/python"
let g:python3_host_prog="~/.pyenv/versions/3.8.12/bin/python"

" For python doc string
let g:pydocstring_doq_path = "~/.pyenv/versions/3.8.12/bin/doq"
let g:pydocstring_formatter = "numpy"



" support njk
au BufRead,BufNewFile *.njk setfiletype html

" Use vim vim-projectionist https://github.com/tpope/vim-projectionist
nnoremap <leader>a :A<CR>
nnoremap <F12> :PlugUpdate<CR>

" my c remap
noremap <F9> : !clang % && print "====RESULT====\n" && ./a.out && rm a.out <CR>

