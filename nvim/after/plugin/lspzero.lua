local lsp_zero = require("lsp-zero").preset({})

vim.o.fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose:>]]
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require("ufo").setup({})

-- Fix Undefined global 'vim'
-- lsp.nvim_workspace()
lsp_zero.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- enable folding by lsp server
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

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>q", function()
		vim.diagnostic.setqflist()
	end, opts)
	vim.keymap.set("n", "<leader>cl", function()
		vim.lsp.codelens.run()
	end, opts)
end)

lsp_zero.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		-- the formatter will not run if your languages are not defined here.
		["null-ls"] = {
			"javascript",
			"typescriptreact",
			"elixir",
			"html",
			"sql",
			"rust",
			"typescript",
			"lua",
			"go",
			"markdown",
			"python",
			"json",
			"jsonc",
			"proto",
		},
	},
})

require("mason").setup()
require("mason-lspconfig").setup({
	-- angularls and tsserver must be installed together in order to run the angularls
	ensure_installed = { "lua_ls", "rust_analyzer", "emmet_ls", "angularls", "pyright", "tsserver", "gopls" },
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

local null_ls = require("null-ls")

-- local function get_extra_args()
-- 	local root = vim.fn.getcwd()
-- 	local angular_json = root .. "/angular.json"
-- 	local has_angular_json = vim.fn.filereadable(angular_json) == 1
-- 	local base = { "--no-trailing-whitespace" }
-- 	if has_angular_json then
-- 		table.insert(base, "--semi")
-- 	end
-- 	return base
-- end

null_ls.setup({
	sources = {
		-- Replace these with the tools you have installed
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.mix,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "javascript", "typescriptreact", "typescript", "css", "html" },
			exclude_filetypes = { "markdown" },
			extra_args = { "--no-trailing-whitespace", "--semi" },
		}),

		null_ls.builtins.formatting.deno_fmt.with({
			filetypes = { "markdown", "jsonc", "json" },
		}),

		null_ls.builtins.formatting.buf, -- protobuf
		-- python
		-- null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.ruff,
		null_ls.builtins.formatting.isort,
		-- rust
		null_ls.builtins.formatting.rustfmt,
		-- golang
		null_ls.builtins.formatting.pg_format,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.gofumpt,
		-- null_ls.builtins.diagnostics.golangci_lint,

		null_ls.builtins.formatting.stylua.with({
			extra_args = { "--column-width=140" },
		}),

		-- for angular
		require("typescript.extensions.null-ls.code-actions"),
	},
})

local cmp = require("cmp")
local cmp_action = require("lsp-zero.cmp").action()
local cmp_format = require("lsp-zero").cmp_format()
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	formatting = cmp_format,
	sources = {
		{ name = "luasnip", keyword_length = 1 }, -- prefer luasnip over lsp because of convenient
		{ name = "buffer", keyword_length = 2 },
		{ name = "nvim_lsp", keyword_length = 2 },
		{ name = "path", keyword_length = 2 },
		{ name = "nvim_lsp_signature_help" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-l>"] = function()
			local ls = require("luasnip")
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end,
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
		["<Up>"] = cmp.mapping.select_prev_item(cmp_select_opts),
		["<Down>"] = cmp.mapping.select_next_item(cmp_select_opts),
		["<C-p>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item(cmp_select_opts)
			else
				cmp.complete()
			end
		end),
		["<CR>"] = function(fallback)
			if cmp.visible() then
				cmp.mapping.confirm({ select = true })(fallback)
			else
				return fallback()
			end
		end,
	},
})
