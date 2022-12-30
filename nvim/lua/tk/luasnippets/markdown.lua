local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local utils = require("tk.luasnippets.utils")


ls.add_snippets("markdown", {
    -- Use a function to execute any shell command and print its text.
    s("tday", f(utils.bash, {}, { user_args = { "date" } })),


}, {
    key = "markdown",
})
