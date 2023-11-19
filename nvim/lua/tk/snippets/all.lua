local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local utils = require("tk.snippets.utils")
-- local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta -- similar to fmt with <> placeholder

local function now_timestamp()
	local s, _ = vim.loop.gettimeofday()
	return tostring(s)
end

local random = math.random
local function uuid()
	local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
	return string.gsub(template, "[xy]", function(c)
		local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
		return string.format("%x", v)
	end)
end

ls.add_snippets("all", {
	s("today", f(utils.bash, {}, { user_args = { "date '+%e %B %Y'" } })),
	s("nts", f(now_timestamp, {}, { user_args = {} })),
	s("uuid", f(uuid, {}, { user_args = {} })),
}, {
	key = "all",
})
