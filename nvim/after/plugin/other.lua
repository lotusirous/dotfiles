local function is_angular_project()
	local root = vim.fn.getcwd()
	local angular_json = root .. "/angular.json"
	return vim.fn.filereadable(angular_json) == 1
end

local function add_vanila_ts(base)
	table.insert(base, {
		pattern = "/(.*)/(.*).ts$",
		target = {
			{
				target = "/%1/%2.spec.ts",
				context = "test",
			},
		},
	})
	table.insert(base, {
		pattern = "/(.*)/(.*).spec.ts$",
		target = {
			{
				target = "/%1/%2.ts",
				context = "script",
			},
		},
	})
end


local function mappings()
	local base = { "golang" }

	if is_angular_project() then
		table.insert(base, "angular")
	else
		add_vanila_ts(base)
	end
	return base
end

require("other-nvim").setup({
	mappings = mappings(),
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
vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>:Other test<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lh", "<cmd>:Other html<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>:Other<CR>", { noremap = true, silent = true })
