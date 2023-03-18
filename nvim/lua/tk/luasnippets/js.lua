local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("javascript", {
    ls.parser.parse_snippet({ trig = "log", wordTrig = false }, "console.log(${1})"),
    s("req", fmt("const {} = require('{}')", { i(1, "default"), rep(1) })),
}, {
    key = "javascript",
})
