local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
-- local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta -- similar to fmt with <> placeholder

ls.add_snippets("json", {
	s(
		"prettier",
		fmta(
			[[
{
  "bracketSpacing": false,
  "singleQuote": true,
  "trailingComma": "es5",
  "arrowParens": "avoid",
  "semi": true,
  "printWidth": 120
}
    ]],
			{}
		)
	),
}, {
	key = "json",
})
