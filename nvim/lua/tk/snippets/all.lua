local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
-- local i = ls.insert_node
-- local c = ls.choice_node
local f = ls.function_node
-- local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta -- similar to fmt with <> placeholder

local random = math.random

local function uuid()
	local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
	return string.gsub(template, "[xy]", function(c)
		local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
		return string.format("%x", v)
	end)
end

ls.add_snippets("all", {
	s("uuid", f(uuid, {}, { user_args = {} })),
})
