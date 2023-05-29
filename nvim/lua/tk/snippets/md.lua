local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local utils = require("tk.snippets.utils")
local extras = require("luasnip.extras")




ls.add_snippets("markdown", {
    -- Use a function to execute any shell command and print its text.
    s("tday", f(utils.bash, {}, { user_args = { "date" } })),

    s("bpost", fmt([[
    ---
    layout: layouts/post.njk
    title: {title}
    date: {date}
    description: {description}
    tags:
        - "golang"
    ---

    ]], {
        title = i(1, ""),
        description = i(2, ""),
        date = extras.partial(os.date, "%Y-%m-%d")

    }))
}, {
    key = "markdown",
})