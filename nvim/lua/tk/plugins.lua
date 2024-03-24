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
	"ThePrimeagen/vim-be-good",
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
			options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
			pre_save = nil, -- a function to call before saving the session
			save_empty = false, -- don't save if there are no open file buffers
		},
		config = function(_, opts)
			require("persistence").setup(opts)
			vim.keymap.set("n", "<leader>ql", require("persistence").load)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
			})

			vim.keymap.set("n", "<leader>ga", "<Cmd>lua require'gitsigns'.stage_hunk()<cr>")
			vim.keymap.set("n", "<leader>gr", "<Cmd>lua require'gitsigns'.reset_hunk()<cr>")
			vim.keymap.set("n", "<leader>gu", "<Cmd>lua require'gitsigns'.undo_stage_hunk()<cr>")
			vim.keymap.set("n", "<leader>gp", "<Cmd>lua require'gitsigns'.preview_hunk()<cr>")
			vim.keymap.set("n", "<leader>gd", "<Cmd>lua require'gitsigns'.diffthis()<cr>")
			vim.keymap.set("n", "<leader>gD", "<Cmd>lua require'gitsigns'.diffthis('~')<cr>")
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				display = {
					render_limit = 16, -- How many LSP messages to show at once
					done_ttl = 3, -- How long a message should persist after completion
					done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
					done_style = "Constant", -- Highlight group for completed LSP tasks
					progress_icon = { pattern = "dots", period = 1 },
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
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		lazy = false,
		config = true,
		opts = {
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
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {
				NormalFloat = { fg = "#f9f5d7", bg = "#32302f" },
				LspReferenceRead = { bg = "#504945" },
				LspReferenceText = { bg = "#504945" },
				-- Visual = { bg = "#42403f", reverse = config.invert_selection },
			},
			dim_inactive = false,
			transparent_mode = true,
		},
	},
	"mattn/vim-goaddtags",
	"ekalinin/Dockerfile.vim",

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
			sections = {
				lualine_b = { "branch", "diff", "grapple" },
				lualine_c = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 1, -- 0: Just the filename
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory

						shorting_target = 40, -- Shortens path to leave 40 spaces in the window
						-- for other components. (terrible name, any suggestions?)
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},
			},
		},
	},

	{
		"cbochs/grapple.nvim",
		opts = {
			scope = "git_branch", -- also try out "git_branch"
			icons = false,
			status = true,
		},
		keys = {
			{ "<C-n>", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
			{ "<C-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
			{ "<leader>h", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
			{ "<leader>j", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
			{ "<leader>k", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
			{ "<leader>l", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
		},
	},
	{ "numToStr/Comment.nvim", opts = {}, event = "VeryLazy" },
	{ "voldikss/vim-floaterm", event = "VeryLazy" },
	{ "sindrets/diffview.nvim", event = "VeryLazy" },

	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ formatters = { "injected" } })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},

		opts = function()
			local opts = {
				-- LazyVim will use these options when formatting with the conform.nvim formatter
				format = {
					timeout_ms = 3000,
					async = false, -- not recommended to change
					quiet = false, -- not recommended to change
				},
				format_on_save = {
					-- I recommend these options. See :help conform.format for details.
					lsp_fallback = true,
					timeout_ms = 500,
				},
				-- The options you set here will be merged with the builtin formatters.
				-- You can also define any custom formatters here.
				---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
				formatters = {
					injected = { options = { ignore_errors = true } },
					-- # Example of using dprint only when a dprint.json file is present
					-- dprint = {
					--   condition = function(ctx)
					--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
					--   end,
					-- },
					--
					-- # Example of using shfmt with extra args
					-- shfmt = {
					--   prepend_args = { "-i", "2", "-ci" },
					-- },
				},
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					go = { "goimports", "gofumpt" },
					-- Use a sub-list to run only the first available formatter
					javascript = { { "prettier" } },
					json = { { "deno_fmt" } },
					jsonc = { { "deno_fmt" } },
					bash = { { "shfmt" } },
					rust = { { "rustfmt" } },
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
					-- Use the "*" filetype to run formatters on all filetypes.
					["*"] = { "typos" },
					-- Use the "_" filetype to run formatters on filetypes that don't
					-- have other formatters configured.
					["_"] = { "trim_whitespace" },
				},
			}

			return opts
		end,
	},
	{ "mbbill/undotree", event = "VeryLazy" },
	"preservim/nerdtree",
	-- "justinmk/vim-dirvish",
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "tpope/vim-abolish", event = "VeryLazy" },
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
	{ "tpope/vim-sleuth", event = "VeryLazy" },
	{ "preservim/tagbar", event = "VeryLazy" },
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
				indent = { char = "│", tab_char = "│" },
				scope = { enabled = false, show_end = true },
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("ufo").setup({
				preview = {
					win_config = {
						border = { "", "─", "", "", "", "─", "", "" },
						-- winhighlight = "Normal:Folded",
						winblend = 0,
					},
				},
			})
		end,
	},

	{
		"ibhagwan/fzf-lua",
		opts = {},
		event = "VeryLazy",
		keys = {
			{ "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
			{ "<leader>`", ":FzfLua marks<CR>", desc = "list all marks" },
			{ "<leader>b", ":FzfLua buffers<CR>", desc = "List all buffers" },
			{ "<C-p>", ":FzfLua files<CR>", desc = "list all files" },
			{ "<leader>fs", ":FzfLua lsp_document_symbols<CR>", desc = "Document Symbols" },
			{ "<leader>fw", ":FzfLua lsp_live_workspace_symbols<CR>", desc = "Workspace Symbols (live query)" },
			{ "<leader>rg", ":FzfLua live_grep_native<CR>", desc = "rg the project" },
			{ "<leader>ft", ":FzfLua filetypes<CR>", desc = "Select file type for current buffer" },
			{ "<leader>km", ":FzfLua keymaps<CR>", desc = "Shows all keymaps" },
			{ "<leader>ca", ":FzfLua lsp_code_actions<CR>", desc = "Show the code action with preview" },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
			},
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"go",
					"rust",
					"lua",
					"python",
					"javascript",
					"typescript",
					"vim",
					"vimdoc",
					"markdown",
					"yaml",
					"json",
					"jsonc",
				},
				autotag = { enable = true },
				autopairs = { enable = true },
				highlight = {
					enable = true, -- false will disable the whole extension
					additional_vim_regex_highlighting = true,
				},
				refactor = {
					highlight_definitions = {
						enable = true,
					},
				},
				-- this options is awful experience for indent
				-- indent = {enable = true, disable = {"yaml"}},
				-- context_commentstring = { enable = true, enable_autocmd = false },
				-- for playground

				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
			})

			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				line_numbers = true,
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
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
			require("tk.snippets.rust")
			require("tk.snippets.json")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{
				"windwp/nvim-autopairs",
				event = "InsertEnter",
				opts = {
					check_ts = true,
					ts_config = {
						lua = { "string", "source" },
						javascript = { "string", "template_string" },
						java = false,
					},
					-- fast_wrap = {
					-- 	map = "<M-e>",
					-- 	chars = { "{", "[", "(", '"' },
					-- 	pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					-- 	offset = 0, -- Offset from pattern match
					-- 	end_key = "$",
					-- 	keys = "qwertyuiopzxcvbnmasdfghjkl",
					-- 	check_comma = true,
					-- 	highlight = "PmenuSel",
					-- 	highlight_grey = "LineNr",
					-- },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					require("nvim-autopairs").get_rules("'")[1].not_filetypes = { "scheme", "lisp", "rust" }
				end,
			},
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- on complete
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			local ls = require("luasnip")
			local cmp_action = require("lsp-zero").cmp_action()

			cmp.setup({
				formatting = lsp_zero.cmp_format(),
				sources = {
					{ name = "path" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "nvim_lsp", keyword_length = 3 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "nvim_lsp_signature_help" },
				},
				sorting = {
					priority_weight = 2,
					-- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,

						-- copied from cmp-under, but I don't think I need the plugin for this.
						-- I might add some more of my own.
						function(entry1, entry2)
							local _, entry1_under = entry1.completion_item.label:find("^_+")
							local _, entry2_under = entry2.completion_item.label:find("^_+")
							entry1_under = entry1_under or 0
							entry2_under = entry2_under or 0
							if entry1_under > entry2_under then
								return false
							elseif entry1_under < entry2_under then
								return true
							end
						end,

						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-k>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					-- next/back place holder for snippets
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					["<C-l>"] = function()
						if ls.choice_active() then
							ls.change_choice(1)
						end
					end,
					["<CR>"] = function(fallback)
						if cmp.visible() then
							return cmp.mapping.confirm({
								behavior = cmp.ConfirmBehavior.Insert,
								select = true,
							})(fallback)
						else
							return fallback()
						end
					end,
				},
			})
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"AndrewRadev/splitjoin.vim",
			"williamboman/mason-lspconfig.nvim",
			-- {
			-- 	"nvimdev/lspsaga.nvim",
			-- 	event = "LspAttach",
			-- 	config = function(_, opts)
			-- 		require("lspsaga").setup({
			-- 			ui = {
			-- 				code_action = "💡",
			-- 			},
			-- 		})
			-- 	end,
			-- },
			{
				"rgroli/other.nvim",
				keys = {
					{ "<leader>o", ":Other<CR>", desc = "Jump to other files" },
				},
				config = function()
					require("other-nvim").setup({
						mappings = {
							-- builtin mappings
							"angular",
							"golang",
							"rust-analyzer",
							"lua-language-server",
						},
						style = {
							-- How the plugin paints its window borders
							-- Allowed values are none, single, double, rounded, solid and shadow
							border = "rounded",

							-- Column separator for the window
							separator = "|",

							-- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
							width = 0.7,

							-- min height in rows.
							-- when more columns are needed this value is extended automatically
							minHeight = 2,
						},
					})
				end,
			},
		},
		config = function()
			vim.diagnostic.config({ virtual_text = true })
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				lsp_zero.highlight_symbol(client, bufnr)

				local opts = { noremap = true, silent = true }
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "<leader>rn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("n", "<leader>q", function()
					vim.diagnostic.setqflist()
				end, opts)
				-- vim.keymap.set("n", "<leader>ca", function()
				-- 	vim.lsp.buf.code_action()
				-- end, opts)
				vim.keymap.set("n", "<leader>cl", function()
					vim.lsp.codelens.run()
				end, opts)
			end)

			lsp_zero.set_server_config({
				capabilities = {
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
			})

			lsp_zero.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "tsserver", "lua_ls", "rust_analyzer", "angularls" },
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		lazy = false,
		config = true,
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"luukvbaal/statuscol.nvim",
		event = "VeryLazy",
		opts = function()
			local builtin = require("statuscol.builtin")
			return {
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{ text = { "%s" }, click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			}
		end,
		config = function(_, opts)
			require("statuscol").setup(opts)
		end,
	},
	{
		"ThePrimeagen/git-worktree.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function(_, opts)
			require("git-worktree").setup()
			require("telescope").load_extension("git_worktree")
			vim.keymap.set("n", "<leader>gb", function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end)
			vim.keymap.set("n", "<leader>gt", function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end)
		end,
	},
}

local opts = {

	ui = {
		border = "rounded",
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅 ",
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
