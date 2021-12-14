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


" Plug 'spf13/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-projectionist'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'

Plug 'dkarter/bullets.vim'
" Plug 'vim-utils/vim-man'

Plug 'preservim/tagbar'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Completion
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'


" Snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'


" let's gruvbox all the things
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'

Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'

Plug 'mattn/vim-goaddtags'
Plug 'rust-lang/rust.vim'


" Breaking bad habit
Plug 'takac/vim-hardtime'

" Read RFC
Plug 'mhinz/vim-rfc'
Plug 'heavenshell/vim-pydocstring'
" Plug 'vimwiki/vimwiki'



call plug#end()

set completeopt=menuone,noselect

colorscheme gruvbox
set background=dark
" transparent bg
hi Normal guibg=NONE ctermbg=NONE

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'



" add LSP config
lua require('lsp')
lua require('compe')
lua require('snippets')
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}




if executable('rg')
    let g:rg_derive_root='true'
endif


" LuaSnip
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" LSP
nnoremap <silent><leader>ca :Lspsaga code_action<CR>

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction


" use this function by :call EmptyRegisters()
fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

" Wonderfull mapping
inoremap <C-c> <esc>
let mapleader = " "


nnoremap <leader>u :UndotreeToggle<CR>
" nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>
" nnoremap <leader>h :wincmd h<CR>
" nnoremap <leader>j :wincmd j<CR>
" nnoremap <leader>k :wincmd k<CR>
" nnoremap <leader>l :wincmd l<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>` :Marks<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <C-p> :Files<CR>

" code search
nnoremap <leader>ps :Rg<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG



" for nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" EasyAlign the code
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>


" Since I'm using nerdtree, i dont' need netrw at all.
"
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" NERDTREE option
let NERDTreeMinimalUI=1
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1



" Enable hard time mode
let g:hardtime_default_on = 0
let g:hardtime_showmsg = 1


" Required environment for many plugins
let g:python_host_prog="~/.pyenv/versions/2.7.18/bin/python"
let g:python3_host_prog="~/.pyenv/versions/3.8.12/bin/python"

" For python doc string
let g:pydocstring_doq_path = "~/.pyenv/versions/3.8.12/bin/doq"
let g:pydocstring_formatter = "numpy"

if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters[';'] = { 'pattern': ';', 'ignore_groups': ['String'] }


" support njk
au BufRead,BufNewFile *.njk setfiletype html

" Use vim vim-projectionist https://github.com/tpope/vim-projectionist
nnoremap <leader>a :A<CR>

" my c remap
noremap <F9> : !clang % && print "====RESULT====\n" && ./a.out && rm a.out <CR>

