vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup()
  end }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end
  }
  use 'nvim-treesitter/nvim-treesitter-context'


  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      {
        "williamboman/mason.nvim",
        run = ":MasonUpdate"
      },

      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }


  use { 'j-hui/fidget.nvim', config = function()
    require "fidget".setup {}
  end }
  use { "ellisonleao/gruvbox.nvim" }
  use 'itchyny/lightline.vim'
  use 'shinchu/lightline-gruvbox.vim'
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = ':call fzf#install()' }
  }

  use 'mbbill/undotree'
  use 'windwp/nvim-autopairs'
  use 'preservim/nerdtree'
  use 'preservim/tagbar'


  use 'tpope/vim-unimpaired'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-sleuth'
  use 'lewis6991/gitsigns.nvim'


  -- use { 'kevinhwang91/nvim-ufo',
  --   requires = 'kevinhwang91/promise-async',
  --   config = function()
  --     require('ufo').setup()
  --   end
  -- }



  -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/integrate-with-null-ls.md
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })



  -- Go development
  use 'buoto/gotests-vim'
  use 'rhysd/vim-go-impl'
  use 'mattn/vim-goaddtags'
end)
