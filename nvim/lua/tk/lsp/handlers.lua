local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end


local group = vim.api.nvim_create_augroup("MyLSPAutogroup", {})



local function lsp_keymaps(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)

	if client.supports_method "textDocument/definition" then
		buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	end

	if client.supports_method "textDocument/hover" then
		buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	end

	if client.supports_method "textDocument/implementation" then
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	end

	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

	if client.supports_method "textDocument/rename" then
		buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end

	buf_set_keymap("n", "<space>lr", "<cmd>lua tk.codelens.run()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)

	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

	if client.supports_method "textDocument/codeLens" then
		buf_set_keymap("n", "<space>lr", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
	end

	buf_set_keymap("n", "<Space><CR>", "<cmd>lua require'lsp.diagnostics'.line_diagnostics()<CR>", opts)

end

-- Set autocommands conditional on resolved_capabilities
-- higlight inline string
-- local function lsp_highlight_document(client)
-- 	if client.server_capabilities.document_highlight then
-- 		vim.api.nvim_exec(
-- 			[[
-- 		augroup lsp_document_highlight
-- 			autocmd! * <buffer>
-- 			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
-- 			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- 		augroup END
-- 		]],
-- 			false
-- 		)
-- 	end
-- end

local function lsp_codelens(client)
	if client.supports_method "textDocument/codeLens" then
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = group,
			pattern = "<buffer>",
			callback = function()
				vim.lsp.codelens.refresh()
			end,
		})
		-- dirty hack
		local timer = vim.loop.new_timer()
		timer:start(300, 0, function()
			timer:close()
			vim.schedule_wrap(function()
				vim.lsp.codelens.refresh()
			end)()
		end)
	end
end

local M = {}


M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)



M.setup = function()
	local config = {
		underline = true,
	}

	vim.diagnostic.config(config)
end

M.on_attach = function(client, bufnr)
	require("lsp-format").on_attach(client)
	lsp_keymaps(client, bufnr)
	lsp_codelens(client)
end

return M
