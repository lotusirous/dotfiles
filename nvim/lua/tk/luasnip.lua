local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local snippet_from_nodes = ls.sn
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = vim.treesitter.get_node_text


-- keymap
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


ls.config.set_config({
    history = false,
    enable_autosnippets = true,
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,

    -- Update more often, :h events for more info.
    update_events = "TextChanged,TextChangedI",
})

-- custom snippets with tree sitter

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
    local file = io.popen(command, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

local same = function(index)
    return f(function(args)
        return args[1]
    end, { index })
end




vim.treesitter.set_query(
    "go",
    "LuaSnip_Result",
    [[ [
    (method_declaration result: (_) @id)
    (function_declaration result: (_) @id)
    (func_literal result: (_) @id)
  ] ]]
)
local transform = function(text, info)
    if text == "int" then
        return t "0"
    elseif text == "error" then
        if info then
            info.index = info.index + 1

            -- return c(info.index, {
            --     t(info.err_name),
            --     t(string.format('fmt.Errorf(%s, "%s")', info.err_name, info.func_name)),
            -- })
            return t(info.err_name)
        else
            return t "err"
        end
    elseif text == "bool" then
        return t "false"
    elseif text == "string" then
        return t '""'
    elseif string.find(text, "*", 1, true) then
        return t "nil"
    end

    return t(text)
end

local handlers = {
    ["parameter_list"] = function(node, info)
        local result = {}

        local count = node:named_child_count()
        for idx = 0, count - 1 do
            table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
            if idx ~= count - 1 then
                table.insert(result, t { ", " })
            end
        end

        return result
    end,

    ["type_identifier"] = function(node, info)
        local text = get_node_text(node, 0)
        return { transform(text, info) }
    end,
}


local function go_result_type(info)
    local cursor_node = ts_utils.get_node_at_cursor()
    local scope = ts_locals.get_scope_tree(cursor_node, 0)

    local function_node
    for _, v in ipairs(scope) do
        if v:type() == "function_declaration" or v:type() == "method_declaration" or v:type() == "func_literal" then
            function_node = v
            break
        end
    end

    local query = vim.treesitter.get_query("go", "LuaSnip_Result")
    for _, node in query:iter_captures(function_node, 0) do
        if handlers[node:type()] then
            return handlers[node:type()](node, info)
        end
    end
end

local go_ret_vals = function(args)
    if args[2] == nil then -- inline error handling
        return snippet_from_nodes(
            nil,
            go_result_type {
                index = 0,
                err_name = "err",
                func_name = "",
            }
        )
    end
    return snippet_from_nodes(
        nil,
        go_result_type {
            index = 0,
            err_name = args[1][1],
            func_name = args[2][1],
        }
    )
end


local copyname = function(args) return args[1] end

ls.add_snippets("go", {
    -- Very long example for a go snippets
    s("ef", {
        i(1, { "val" }),
        t ", err := ",
        i(2, { "f" }),
        t "(",
        i(3),
        t ")",
        i(0),
    }),

    s("iferr", {
        i(1, { "val" }),
        t ", ",
        i(2, { "err" }),
        t " := ",
        i(3, { "f" }),
        t { "", "if " },
        same(2),
        t { " != nil {", "\treturn " },
        d(4, go_ret_vals, { 2, 3 }),
        t { "", "}" },
        i(0),
    }),

    s("ile", {
        t "if err := ",
        i(1, { "f" }),
        t "; ",
        t { "err != nil {", "\treturn " },
        d(2, go_ret_vals, { 1, nil }),
        t { "", "}" },
        i(0),
    }),

    s("pf", {
        -- Simple static text.
        t("// "),
        -- function, first parameter is the function, second the Placeholders
        -- whose text it gets as input.
        f(copyname, 1), t " ", -- space after descriptinon
        i(4, { "..." }), -- paste function name
        t({ "", "func " }), -- Placeholder/Insert.
        i(1), t("("), -- Placeholder with initial text.
        i(2, ""), t(")"), i(3, { " error " }), -- Linebreak
        t({ "{", "\t" }),
        -- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
        i(0), t({ "", "}" })
    })


}, {
    key = "go",
})


ls.add_snippets("javascript", {
    ls.parser.parse_snippet(
        { trig = "log", wordTrig = false },
        "console.log(${1})"
    ),

    s("req", fmt("const {} = require('{}')", { i(1, "default"), rep(1) }))

}, {
    key = "javascript",
})

ls.add_snippets("markdown", {
    -- Use a function to execute any shell command and print its text.
    s("tday", f(bash, {}, { user_args = { "date" } })),

}, {
    key = "markdown",
})


require("luasnip.loaders.from_vscode").load({ include = { "all" } }) -- Load all snippets
