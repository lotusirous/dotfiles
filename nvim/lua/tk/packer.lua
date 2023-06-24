vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("tk.treesitter")
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
		config = function()
			require("tk.lspzero")
		end,
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
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("tk.luasnip")
				end,
			},
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

	use({
		"j-hui/fidget.nvim",
		branch = "legacy",
		config = function()
			require("fidget").setup({
				text = {
					spinner = "dots", -- animation shown when tasks are ongoing
					done = "✔", -- character shown when all tasks are complete
					commenced = "Started", -- message shown when task starts
					completed = "Completed", -- message shown when task completes
				},
				window = {
					relative = "win", -- where to anchor, either "win" or "editor"
					blend = 0, -- &winblend for the window
					zindex = nil, -- the zindex value for the window
					border = "none", -- style of border for the fidget window
				},
			})
		end,
	})

	-- use("itchyny/lightline.vim")
	-- use("itchyny/vim-gitbranch")
	-- use("shinchu/lightline-gruvbox.vim")
	use({
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("tk.colorscheme")
		end,
	})
	use({ "nvim-lualine/lualine.nvim" })

	use({
		"junegunn/fzf.vim",
		requires = { "junegunn/fzf", run = ":call fzf#install()" },
	})

	use("mbbill/undotree")
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("tk.autopairs")
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = { "html", "xml" },
			})
		end,
	})
	use("preservim/nerdtree")
	use("preservim/tagbar")

	use("tpope/vim-abolish")
	use("tpope/vim-unimpaired")
	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
	use("tpope/vim-sleuth")
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("tk.gitsigns")
		end,
	})

	use({
		"lotusirous/clipboard-image.nvim",
		config = function()
			require("tk.clipboard-image")
		end,
	})

	-- Go development
	use("buoto/gotests-vim")
	use("rhysd/vim-go-impl")
	use("mattn/vim-goaddtags")

	use({
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)")
			vim.g.easy_align_delimiters = {
				[";"] = { pattern = ";", left_margin = 0 },
				["["] = { pattern = "[", left_margin = 1, right_margin = 0 },
				["]"] = { pattern = "]", left_margin = 0, right_margin = 1 },
				[","] = { pattern = ",", left_margin = 0, right_margin = 1 },
				[")"] = { pattern = ")", left_margin = 0, right_margin = 0 },
				["("] = { pattern = "(", left_margin = 0, right_margin = 0 },
				["="] = { pattern = [[<\?=>\?]], left_margin = 1, right_margin = 1 },
				["|"] = { pattern = [[|\?|]], left_margin = 1, right_margin = 1 },
				["&"] = { pattern = [[&\?&]], left_margin = 1, right_margin = 1 },
				[":"] = { pattern = ":", left_margin = 1, right_margin = 1 },
				["?"] = { pattern = "?", left_margin = 1, right_margin = 1 },
				["<"] = { pattern = "<", left_margin = 1, right_margin = 0 },
				[">"] = { pattern = ">", left_margin = 1, right_margin = 0 },
				["+"] = { pattern = "+", left_margin = 1, right_margin = 1 },
			}
		end,
	})

	use({ "dstein64/vim-startuptime" })
	use({ "voldikss/vim-floaterm" })
	use({
		"rgroli/other.nvim",
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>:Other test<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>lh", "<cmd>:Other html<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>:Other<CR>", { noremap = true, silent = true })
			require("other-nvim").setup({
				mappings = {
					-- builtin mappings
					"angular",
					"golang",
				},
				transformers = {
					-- defining a custom transformer
					lowercase = function(inputString)
						return inputString:lower()
					end,
				},
				style = {
					-- How the plugin paints its window borders
					-- Allowed values are none, single, double, rounded, solid and shadow
					border = "rounded",

					-- Column seperator for the window
					seperator = "|",

					-- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
					width = 0.7,

					-- min height in rows.
					-- when more columns are needed this value is extended automatically
					minHeight = 2,
				},
			})
		end,
	})
end)
