local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local types = require("luasnip.util.types")
local d = ls.dynamic_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.conditions")

-- Every unspecified option will be set to the default.
ls.config.set_config(
    {
        history = true,
        -- Update more often, :h events for more info.
        updateevents = "TextChanged,TextChangedI",
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    virt_text = {{"choiceNode", "Comment"}}
                }
            }
        },
        -- treesitter-hl has 100, use something higher (default is 200).
        ext_base_prio = 300,
        -- minimal increase in priority.
        ext_prio_increase = 1,
        enable_autosnippets = true
    }
)

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
    local fmt = fmt or "%Y-%m-%d"
    return sn(nil, i(1, os.date(fmt)))
end

ls.snippets = {
    -- When trying to expand a snippet, luasnip first searches the tables for
    -- each filetype specified in 'filetype' followed by 'all'.
    -- If ie. the filetype is 'lua.c'
    --     - luasnip.lua
    --     - luasnip.c
    --     - luasnip.all
    -- are searched in that order.
    python = {
        s(
            -- basic logging
            "blg",
            t(
                {
                    "logging.basicConfig(",
                    "\tlevel=logging.DEBUG,",
                    '\tformat="%(asctime)s,%(msecs)d %(levelname)s: %(message)s",',
                    '\tdatefmt="%H:%M:%S",',
                    ")"
                }
            )
        )
    },
    markdown = {
        s("mdt", d(1, date_input, {}, "%A, %B %d of %Y")),
        s(
            "bpost",
            fmt(
                [[
            ---
            layout: layouts/post.njk
            title: "{1}"
            date: {2}
            description: {3}
            ---
			]],
                {
                    i(1, "title"),
                    i(2, os.date("%Y-%m-%d")),
                    i(3, "description")
                }
            )
        )
    }
}

-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
-- ls.autosnippets = {
--     all = {
--         s(
--             "autotrigger",
--             {
--                 t("autosnippet")
--             }
--         )
--     }
-- }

-- in a lua file: search lua-, then c-, then all-snippets.
ls.filetype_extend("lua", {"c"})
-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
ls.filetype_set("cpp", {"c"})

--[[
-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
]]
require("luasnip/loaders/from_vscode").load({include = {"python"}}) -- Load only python snippets
-- The directories will have to be structured like eg. <https://github.com/rafamadriz/friendly-snippets> (include
-- a similar `package.json`)
require("luasnip/loaders/from_vscode").load({paths = {"./my-snippets"}}) -- Load snippets from my-snippets folder

-- You can also use lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} as well
