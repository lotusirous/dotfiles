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

        -- undo tree
        use 'mbbill/undotree'

        -- quick fix list
        use 'tpope/vim-unimpaired'

        -- git
        use 'tpope/vim-fugitive'
        -- show git blame
        use {
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require('gitsigns').setup() end
        }

        use 'editorconfig/editorconfig-vim'

        use 'windwp/nvim-autopairs'

        -- markdown
        -- This plugin will conflict with compe because
        -- it removes the auto competion
        -- use 'dkarter/bullets.vim'

        -- UI
        use 'Yggdroot/indentLine'
        use 'itchyny/lightline.vim'
        use {
            'ntpeters/vim-better-whitespace',
            config = function()
                vim.cmd("let g:better_whitespace_enabled=1")
                vim.cmd("let g:strip_whitespace_on_save=1")
                vim.cmd("let g:strip_whitespace_confirm=0")
                vim.cmd("let g:strip_whitelines_at_eof=1")
            end
        }

        -- go development
        use 'fatih/vim-go'

        -- rust
        use 'rust-lang/rust.vim'
        use 'rust-lang-nursery/rustfmt'

        -- explorer tree
        use 'preservim/nerdtree'

        -- Best theme ever
        use 'gruvbox-community/gruvbox'

        -- Language Support --
        use 'kabouzeid/nvim-lspinstall'
        use 'neovim/nvim-lspconfig'
        use 'lspcontainers/lspcontainers.nvim'
        use {
            'hrsh7th/nvim-compe',
            requires = {'neovim/nvim-lspconfig'},
            config = function()
                require'compe'.setup {
                    enabled = true,
                    autocomplete = true,
                    debug = false,
                    min_length = 1,
                    preselect = 'enable',
                    throttle_time = 80,
                    source_timeout = 200,
                    incomplete_delay = 400,
                    max_abbr_width = 100,
                    max_kind_width = 100,
                    max_menu_width = 100,
                    documentation = true,

                    source = {
                        path = true,
                        buffer = true,
                        calc = true,
                        nvim_lsp = true,
                        nvim_lua = true,
                        vsnip = true
                        -- ultisnips = true
                    }
                }

            end
        }
        -- use {'tzachar/compe-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-compe'}

        use {'hrsh7th/vim-vsnip', requires = {'hrsh7th/nvim-compe'}}
        -- use {'SirVer/ultisnips', requires = {'hrsh7th/nvim-compe'}}
        use {'rafamadriz/friendly-snippets', requires = {'hrsh7th/nvim-compe'}}
        -- search code base
        use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
        use 'junegunn/fzf.vim'

        -- utils
        use {
            'AndrewRadev/splitjoin.vim',
            cmd = {'SplitjoinSplit', 'SplitjoinJoin'}
        }
        use 'godlygeek/tabular'
        use 'junegunn/vim-easy-align'

        -- comment
        use 'tpope/vim-commentary'

        use 'mhinz/vim-rfc'

        use 'sbdchd/neoformat'

    end)
end

local function init()
    packer_verify()
    packer_startup()
end

return {init = init}
