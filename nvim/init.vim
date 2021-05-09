set path+=**

" Nice menu when typing `:find *.py`
"set wildmode=longest,list,full
"set wildmenu



" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*


call plug#begin('~/.config/nvim/plugged')
" UI
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'Yggdroot/indentLine' " Indent the line


" language server
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'kosayoda/nvim-lightbulb'

"Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }


" self-help
"
Plug 'ThePrimeagen/vim-be-good'


" Git
Plug 'tpope/vim-fugitive'

" Markdown utils
Plug 'dkarter/bullets.vim'

" Quick fix list mapping
Plug 'tpope/vim-unimpaired'

" An incremental parsing system for programming tools
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" The undo history visualizer for VIM
Plug 'mbbill/undotree'

" Merge or split 2 line
Plug 'AndrewRadev/splitjoin.vim'

" Search tool
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" Insert or delete brackets, parens, quotes in pair.
Plug 'windwp/nvim-autopairs'

" Make table awesome
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'


" for rust
Plug 'rust-lang-nursery/rustfmt'
Plug 'rust-lang/rust.vim'

" Read RFC
Plug 'mhinz/vim-rfc'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


" snippet
Plug 'hrsh7th/vim-vsnip'
Plug 'SirVer/ultisnips'
Plug 'norcalli/snippets.nvim'
Plug 'rafamadriz/friendly-snippets'
"Plug 'hrsh7th/vim-vsnip-integ'


" prettier
Plug 'sbdchd/neoformat'

call plug#end()


colorscheme gruvbox
set background=dark

lua require("khant")


function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction


" Convert to cammelCase to snake_case
function ToSnakeCase()
  %s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g
  ''
endfunction

" Auto trim whitespace by default
autocmd BufWritePre * call TrimWhiteSpace()


" faster for rg
if executable('rg')
    let g:rg_derive_root='true'
endif

" Rustlang ploptions
let g:rustfmt_autosave = 1


" markdown
let g:bullets_enabled_file_types = [
    \ 'markdown'
    \]


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

" Copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
