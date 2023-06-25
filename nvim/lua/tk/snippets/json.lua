local ls = require("luasnip")
local s = ls.snippet
-- local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("json", {
	s(
		"prettier",
		fmt(
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
