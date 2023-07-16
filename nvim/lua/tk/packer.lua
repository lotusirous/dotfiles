vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({ "numToStr/Comment.nvim" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		requires = {
			{ "nvim-treesitter/nvim-treesitter-context" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			-- { "nvim-treesitter/playground" },
		},
	})

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				run = ":MasonUpdate",
			},

			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			-- formatting
			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/integrate-with-null-ls.md
			{
				"jose-elias-alvarez/null-ls.nvim",
				requires = { "nvim-lua/plenary.nvim" },
			},
			-- for typescript
			{ "jose-elias-alvarez/typescript.nvim" },
		},
	})

	use({ "j-hui/fidget.nvim", branch = "legacy" })

	-- use("itchyny/lightline.vim")
	-- use("itchyny/vim-gitbranch")
	-- use("shinchu/lightline-gruvbox.vim")
	use({ "ellisonleao/gruvbox.nvim" })
	use({ "nvim-lualine/lualine.nvim" })

	use({
		"junegunn/fzf.vim",
		requires = { "junegunn/fzf", run = ":call fzf#install()" },
	})

	use("mbbill/undotree")
	use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-ts-autotag" })
	use("preservim/nerdtree")

	use("tpope/vim-abolish")
	use("tpope/vim-unimpaired")
	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
	use("tpope/vim-sleuth")
	use({ "lewis6991/gitsigns.nvim" })

	-- Go development
	use("buoto/gotests-vim")
	use("vim-test/vim-test")
	use("mattn/vim-goaddtags")

	-- use({
	-- 	"junegunn/vim-easy-align",
	-- 	config = function()
	-- 		vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)")
	-- 		vim.g.easy_align_delimiters = {
	-- 			[";"] = { pattern = ";", left_margin = 0 },
	-- 			["["] = { pattern = "[", left_margin = 1, right_margin = 0 },
	-- 			["]"] = { pattern = "]", left_margin = 0, right_margin = 1 },
	-- 			[","] = { pattern = ",", left_margin = 0, right_margin = 1 },
	-- 			[")"] = { pattern = ")", left_margin = 0, right_margin = 0 },
	-- 			["("] = { pattern = "(", left_margin = 0, right_margin = 0 },
	-- 			["="] = { pattern = [[<\?=>\?]], left_margin = 1, right_margin = 1 },
	-- 			["|"] = { pattern = [[|\?|]], left_margin = 1, right_margin = 1 },
	-- 			["&"] = { pattern = [[&\?&]], left_margin = 1, right_margin = 1 },
	-- 			[":"] = { pattern = ":", left_margin = 1, right_margin = 1 },
	-- 			["?"] = { pattern = "?", left_margin = 1, right_margin = 1 },
	-- 			["<"] = { pattern = "<", left_margin = 1, right_margin = 0 },
	-- 			[">"] = { pattern = ">", left_margin = 1, right_margin = 0 },
	-- 			["+"] = { pattern = "+", left_margin = 1, right_margin = 1 },
	-- 		}
	-- 	end,
	-- })
	--
	-- use({ "dstein64/vim-startuptime" })
	use("lukas-reineke/indent-blankline.nvim")
	use({ "voldikss/vim-floaterm" })
	use({ "rgroli/other.nvim" })
	use("dstein64/vim-startuptime")
	use("preservim/tagbar")
	-- use({ "simrat39/symbols-outline.nvim" })
end)
