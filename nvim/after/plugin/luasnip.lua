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
