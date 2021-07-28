local function packer_verify()
    local cmd = vim.api.nvim_command
    local fn = vim.fn

    local install_path = fn.stdpath('data') ..
                             '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
            install_path
        })
        cmd 'packadd packer.nvim'
    end
end

local function packer_startup()
    require('packer').startup(function(use)
        -- Packer --
        use 'wbthomason/packer.nvim'

        -- game
        use 'ThePrimeagen/vim-be-good'
        -- undo tree
        use 'mbbill/undotree'

        -- quick fix list
        use 'tpope/vim-unimpaired'
        use {
            'nvim-treesitter/nvim-treesitter',
            run = 'TSUpdate',
            config = function()
                require'nvim-treesitter.configs'.setup {
                    ensure_installed = {
                        'bash', 'css', 'dockerfile', 'go', 'gomod', 'graphql',
                        'html', 'javascript', 'jsdoc', 'json', 'lua', 'python',
                        'rust', 'tsx', 'typescript', 'yaml'
                    },
                    highlight = {enable = true},
                    indent = {enable = true}
                }
            end
        }

        -- git
        use 'tpope/vim-fugitive'
        -- show git blame
        use {
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require('gitsigns').setup() end
        }

        -- format and code edit
        use 'editorconfig/editorconfig-vim'

        use 'windwp/nvim-autopairs'

        use 'mattn/emmet-vim'
        -- markdown
        -- This plugin will conflict with compe because
        -- it removes the auto completion
        -- use 'dkarter/bullets.vim'

        -- UI
        -- use 'Yggdroot/indentLine'
        use 'itchyny/lightline.vim'
        -- use {
        --     'ntpeters/vim-better-whitespace',
        --     config = function()
        --         vim.cmd("let g:better_whitespace_enabled=1")
        --         vim.cmd("let g:strip_whitespace_on_save=1")
        --         vim.cmd("let g:strip_whitespace_confirm=0")
        --         vim.cmd("let g:strip_whitelines_at_eof=1")
        --     end
        -- }

        -- Development life
        use 'fatih/vim-go'

        -- kotlin
        -- use 'udalov/kotlin-vim'

        -- rust
        use 'rust-lang/rust.vim'
        use 'rust-lang-nursery/rustfmt'

        -- Utils
        -- explorer tree
        use 'preservim/nerdtree'
        -- Best theme ever
        use 'gruvbox-community/gruvbox'

        -- Language Support --
        use 'neovim/nvim-lspconfig'
        use {'hrsh7th/nvim-compe', requires = {'neovim/nvim-lspconfig'}}

        use {'hrsh7th/vim-vsnip', requires = {'hrsh7th/nvim-compe'}}
        use {'norcalli/snippets.nvim', requires = {'hrsh7th/nvim-compe'}}
        -- use {'SirVer/ultisnips', requires = {'hrsh7th/nvim-compe'}}
        use {'rafamadriz/friendly-snippets', requires = {'hrsh7th/nvim-compe'}}

        -- search code base
        use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
        use 'junegunn/fzf.vim'

        -- utils
        -- use 'AndrewRadev/splitjoin.vim'
        use 'godlygeek/tabular'
        use 'junegunn/vim-easy-align'

        -- utils
        use 'tpope/vim-commentary'
        use 'mhinz/vim-rfc'

        use 'takac/vim-hardtime'

        use {
            'heavenshell/vim-pydocstring',
            ft = {'python'},
            run = 'make install'
        }
    end)
end

local function init()
    packer_verify()
    packer_startup()
end

return {init = init}
