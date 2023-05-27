vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer itself
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    use 'gruvbox-community/gruvbox'

    -- Statusline
    use 'itchyny/lightline.vim'
    use 'shinchu/lightline-gruvbox.vim'

    -- Undo Tree
    use 'mbbill/undotree'

    -- Autopairs
    use 'windwp/nvim-autopairs'

    -- NERDTree
    use 'preservim/nerdtree'

    -- Fuzzy Finder
    use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
    use 'junegunn/fzf.vim'

    -- Tagbar
    use 'preservim/tagbar'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({with_sync = true})
        end
    }
    use 'nvim-treesitter/nvim-treesitter-context'

    -- Commenting
    use 'numToStr/Comment.nvim'

    -- Unimpaired

    -- Fugitive
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-sleuth'

    use {
        'lewis6991/gitsigns.nvim',
        config = require('tk.gitsigns')
        -- config = function()
        --     require('gitsigns').setup({
        --         current_line_blame_opts = {
        --             virt_text = true,
        --             virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        --             delay = 100,
        --             ignore_whitespace = false
        --         }
        --     })
        -- end
    }

    -- SplitJoin
    use 'AndrewRadev/splitjoin.vim'

    -- Emmet
    use 'mattn/emmet-vim'

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = false

            }
        end
    }

    -- Easy Align
    use 'junegunn/vim-easy-align'

    -- Bullets for Markdown
    use 'dkarter/bullets.vim'

    -- LSP and Completion
    use 'neovim/nvim-lspconfig'
    use 'lukas-reineke/lsp-format.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'

    -- Friendly Snippets
    use 'rafamadriz/friendly-snippets'

    -- Go development
    use 'buoto/gotests-vim'
    use 'rhysd/vim-go-impl'
    use 'mattn/vim-goaddtags'

    -- Rust
    use 'rust-lang/rust.vim'

    -- Python development
    use 'heavenshell/vim-pydocstring'
end)
