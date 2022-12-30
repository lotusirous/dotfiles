local ls = require("luasnip")
-- require("luasnip.loaders.from_vscode").load({ include = { "all" } }) -- Load all snippets
require("luasnip.loaders.from_vscode").lazy_load()


ls.config.set_config({
	history = false,
	enable_autosnippets = true,
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,

	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
})


-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")


-- Load snippets
require("tk.luasnippets.go")
require("tk.luasnippets.js")
require("tk.luasnippets.markdown")