local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

configs.setup({
	ensure_installed = {
		"go",
		"lua",
		"c",
		"sql",
		"python",
		"javascript",
		"typescript",
		"rust",
		"vim",
		"bash",
		"markdown",
		"yaml",
		"java",
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = { enable = true },
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	-- this options is awful experience for ident
	-- indent = {enable = true, disable = {"yaml"}},
	context_commentstring = { enable = true, enable_autocmd = false },
})
