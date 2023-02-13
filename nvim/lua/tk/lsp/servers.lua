local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local on_attach = require("tk.lsp.handlers").on_attach
local capabilities = require("tk.lsp.handlers").capabilities

-- Server settings

local lua_lsp_root_path = "/Users/gru-2019015/local/lsp/lua-language-server/bin"
local lua_lsp_binary = lua_lsp_root_path .. "/lua-language-server"

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr) -- another tool will take care of this
		client.server_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end,
	flags = { debounce_text_changes = 150 },
})

lspconfig.clangd.setup({
	on_attach = function(client, bufnr) -- another tool will take care of this
		client.server_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
		"--background-index",
		"--suggest-missing-includes",
		"--fallback-style=gnu",
		"--all-scopes-completion",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
	},
	root_dir = function()
		return vim.loop.cwd()
	end,
})

lspconfig.gopls.setup({
	capabilities = capabilities,
	cmd = { "gopls", "serve" },
	on_attach = function(client, bufnr) -- another tool will take care of this
		client.server_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end,
	settings = {
		gopls = {
			usePlaceholders = false, -- this is bad, do not use this shit.
			codelenses = { test = true },
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},

	flags = { debounce_text_changes = 200 },
})

lspconfig.lua_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { lua_lsp_binary, "-E", lua_lsp_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.hls.setup({ on_attach = on_attach, capabilities = capabilities })

lspconfig.dockerls.setup({ on_attach = on_attach })
lspconfig.sourcekit.setup({ on_attach = on_attach })




-- https://github.com/vscode-langservers/vscode-json-languageserver
lspconfig.jsonls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "vscode-json-languageserver", "--stdio" },
	settings = {
		json = {
			-- Schemas https://www.schemastore.org
			schemas = {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "tsconfig*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
				{
					fileMatch = {
						".prettierrc",
						".prettierrc.json",
						"prettier.config.json",
					},
					url = "https://json.schemastore.org/prettierrc.json",
				},
				{
					fileMatch = { ".eslintrc", ".eslintrc.json" },
					url = "https://json.schemastore.org/eslintrc.json",
				},
				{
					fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
					url = "https://json.schemastore.org/babelrc.json",
				},
				{
					fileMatch = { "lerna.json" },
					url = "https://json.schemastore.org/lerna.json",
				},
				{
					fileMatch = {
						".stylelintrc",
						".stylelintrc.json",
						"stylelint.config.json",
					},
					url = "http://json.schemastore.org/stylelintrc.json",
				},
				{
					fileMatch = { "/.github/workflows/*" },
					url = "https://json.schemastore.org/github-workflow.json",
				},
			},
		},
	},
}


local languages = require("tk.efm.langs")
lspconfig.efm.setup {
	capabilities = capabilities,
	on_attach = function(client, bufr)
		client.server_capabilities.completionProvider = false
		on_attach(client, bufr)
	end,
	init_options = { documentFormatting = true },
	root_dir = vim.loop.cwd,
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = { ".git/" },
		logLevel = 2,
		lintDebounce = 100,
		languages = languages
	},
}
