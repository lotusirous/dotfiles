local ts = require("typescript")

-- local group = vim.api.nvim_create_augroup("ts", { clear = true })
-- vim.api.nvim_create_autocmd("BufWrite", {
-- 	group = group,
-- 	pattern = "*.ts",
-- 	callback = function()
-- 		ts.actions.removeUnused({ sync = true })
-- 		ts.actions.organizeImports({ sync = true })
-- 	end,
-- })

-- It does not work
-- vim.keymap.set("n", "<leader>ts", function()
-- 	ts.actions.goToSourceDefinition(vim.api.nvim_get_current_win(), { sync = true })
-- end, { noremap = true })
vim.keymap.set("n", "<leader>tf", function()
	ts.actions.removeUnused({ sync = true })
	ts.actions.organizeImports({ sync = true })
end, { noremap = true })
vim.keymap.set("n", "<leader>ti", function()
	ts.actions.addMissingImports({ sync = true })
end, { noremap = true })
