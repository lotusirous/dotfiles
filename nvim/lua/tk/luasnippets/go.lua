local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

local utils = require ("tk.luasnippets.utils")

ls.add_snippets("go", {
    s("pf", {
        t("// "),
        utils.same(1),
        t(" "), -- space after descriptinon
        i(4, { "..." }), -- paste function name
        t({ "", "func " }), -- Placeholder/Insert.
        i(1),
        t("("), -- Placeholder with initial text.
        i(2, ""),
        t(") "),
        i(3), -- Linebreak
        t({ "{", "\t" }),
        i(4),
        t({ "", "}" }),
    }),

    s("iferr", {
        t({"if err != nil {", ""}),
        t("\t"),
        i(1),
        t({"","}"})
    }),

    s("hands", { -- http handler func
        t("// "),
        utils.same(1),
        t(" returns an http.HandlerFunc that processes http requests to "),
        i(2, { "..." }),
        t({ "", "func " }), -- new line and add the func at the beginning.
        i(1),
        t({ "(w http.ResponseWriter, r *http.Request) {" }),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
}, {
    key = "go",
})

