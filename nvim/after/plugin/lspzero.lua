require("mason").setup()
require("mason-lspconfig").setup({
	-- angularls and tsserver must be installed together in order to run the angularls
	ensure_installed = { "lua_ls", "emmet_ls", "angularls", "pyright", "tsserver", "gopls" },
})

local lsp = require("lsp-zero").preset({})

-- enable folding by lsp server
lsp.set_server_config({
	capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
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

lsp.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		-- the formatter will not run if your languages are not defined here.
		["null-ls"] = { "javascript", "html", "typescript", "lua", "go", "markdown", "python", "json", "jsonc" },
	},
})

lsp.setup()

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
		null_ls.builtins.formatting.prettierd.with({
			filetypes = { "javascript", "typescript", "css", "html" },
			exclude_filetypes = { "markdown" },
			extra_args = { "--no-trailing-whitespace", "--semi" },
		}),

		null_ls.builtins.formatting.deno_fmt.with({
			filetypes = { "markdown", "jsonc", "json" },
		}),
		-- python
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		-- golang
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.diagnostics.golangci_lint,

		null_ls.builtins.diagnostics.eslint_d,

		null_ls.builtins.formatting.stylua,

		-- for angular
		require("typescript.extensions.null-ls.code-actions"),
		-- null_ls.builtins.diagnostics.eslint_d.with({
		--   filetypes = {"javascript", "typescript"}
		-- }),
	},
})

require("lsp-zero").extend_cmp()
local cmp = require("cmp")
local cmp_action = require("lsp-zero.cmp").action()
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "nvim_lsp_signature_help" },
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
