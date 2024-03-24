local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
-- local c = ls.choice_node

-- local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta -- similar to fmt with <> placeholder
local fmta = require("luasnip.extras.fmt").fmta -- similar to fmt with <> placeholder

ls.add_snippets("rust", {
	s(
		"ctest",
		fmta(
			[[
#[cfg(test)]
mod tests {
    use super::*;

	#[test]
    fn <name>() {
        <body>
    }
}
    ]],
			{ name = i(1), body = i(2) }
		)
	),
}, {
	key = "rust",
})
