local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "numToStr/Comment.nvim",  opts = {},         event = "VeryLazy" },
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<C-n>", mark.add_file)
			vim.keymap.set("n", "<C-m>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<C-0>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<C-9>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<C-8>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<C-7>", function()
				ui.nav_file(4)
			end)
		end,
	},
	-- {
	--     "folke/tokyonight.nvim",
	--     lazy = false,
	--     priority = 1000,
	--     opts = {},
	--   },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		lazy = false,
		config = true,
		opts = {
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = false,
				comments = false,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {
				-- NormalFloat = { fg = "#f9f5d7", bg = "#32302f" },
				-- NonText = { fg = "#32302f"},
			},
			dim_inactive = false,
			transparent_mode = true,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",
				theme = "gruvbox-material",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			npairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
					java = false,
				},
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0, -- Offset from pattern match
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
				enable_check_bracket_line = false,
			})
			npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp" }
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		end,
	},
	-- "lewis6991/gitsigns.nvim",

	{ "voldikss/vim-floaterm",  event = "VeryLazy" },
	{ "sindrets/diffview.nvim", event = "VeryLazy" },

	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				go = { "goimports", "gofumpt" },
				-- Use a sub-list to run only the first available formatter
				javascript = { { "prettier" } },
				css = { { "prettier" } },
				typescript = { { "prettier" } },
				markdown = { { "deno_fmt" } },
				-- You can use a function here to determine the formatters dynamically
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,
				rust = { "rustfmt" },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
		dependencies = {
			{
				"j-hui/fidget.nvim",
				opts = {
					progress = {
						display = {
							render_limit = 16, -- How many LSP messages to show at once
							done_ttl = 3, -- How long a message should persist after completion
							done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
							done_style = "Constant", -- Highlight group for completed LSP tasks
						},
					},
					notification = {
						poll_rate = 10,
						window = {
							normal_hl = "Comment", -- Base highlight group in the notification window
							winblend = 0, -- Background color opacity in the notification window
							border = "none", -- Border around the notification window
							zindex = 45, -- Stacking priority of the notification window
							max_width = 0, -- Maximum width of the notification window
							max_height = 0, -- Maximum height of the notification window
							x_padding = 1, -- Padding from right edge of window boundary
							y_padding = 0, -- Padding from bottom edge of window boundary
							align = "bottom", -- How to align the notification window
							relative = "editor", -- What the notification window position is relative to
						},
					},
				},
			},
		},
	},

	-- "itchyny/vim-gitbranch",
	-- "shinchu/lightline-gruvbox.vim",
	-- "tpope/vim-abolish",
	-- "buoto/gotests-vim",
	-- "mattn/vim-goaddtags",

	{ "mbbill/undotree",           event = "VeryLazy" },
	"preservim/nerdtree",
	{ "tpope/vim-unimpaired",      event = "VeryLazy" },
	{ "tpope/vim-fugitive",        event = "VeryLazy" },
	{ "tpope/vim-rhubarb",         event = "VeryLazy" },
	{ "tpope/vim-sleuth",          event = "VeryLazy" },
	{ "preservim/tagbar",          event = "VeryLazy" },
	{ "AndrewRadev/splitjoin.vim", event = "VeryLazy" },
	"nvim-lua/plenary.nvim",
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = false },
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc },      click = "v:lua.ScFa" },
							{ text = { "%s" },                  click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
		config = function()
			require("ufo").setup({})
		end,
	},

	{
		"ibhagwan/fzf-lua",
		opts = {},
		event = "VeryLazy",
		keys = {
			{ "<leader>ft", "<cmd>Neotree toggle<cr>",                desc = "NeoTree" },
			{ "<leader>`",  ":FzfLua marks<CR>",                      desc = "list all marks" },
			{ "<leader>b",  ":FzfLua buffers<CR>",                    desc = "list all buffers" },
			{ "<C-p>",      ":FzfLua files<CR>",                      desc = "list all files" },
			{ "<leader>fs", ":FzfLua lsp_document_symbols<CR>",       desc = "Document Symbols" },
			{ "<leader>fw", ":FzfLua lsp_live_workspace_symbols<CR>", desc = "Workspace Symbols (live query)" },
			{ "<leader>rg", ":FzfLua live_grep_native<CR>",           desc = "rg the project" },
			{ "<leader>ft", ":FzfLua filetypes<CR>",                  desc = "define current buffer file type" },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-context" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		config = function()
			require("tk.treesitter")
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = { { "rafamadriz/friendly-snippets" } },
		event = "VeryLazy",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").config.set_config({
				history = false,
				enable_autosnippets = true,
				-- treesitter-hl has 100, use something higher (default is 200).
				ext_base_prio = 300,
				-- minimal increase in priority.
				ext_prio_increase = 1,
				-- Update more often, :h events for more info.
				updateevents = "TextChanged,TextChangedI",
			})

			require("tk.snippets.all")
			require("tk.snippets.go")
			require("tk.snippets.js")
			require("tk.snippets.json")
			require("tk.snippets.md")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		branch = "v3.x",
		config = function()
			require("tk.lspzero")
		end,
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			{
				"rgroli/other.nvim",
				keys = {
					{ "<leader>ll", ":Other<CR>", desc = "Jump to other files" },
				},
				config = function()
					require("other-nvim").setup({
						mappings = { "golang", "angular" },
					})
				end,
			},
		},
	},
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "single",
			},
		},
	},
}

local opts = {

	ui = {
		border = "rounded",
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
}
require("lazy").setup(plugins, opts)
