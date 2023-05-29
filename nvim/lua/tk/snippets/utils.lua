local ls = require("luasnip")
local f = ls.function_node

local M = {}

M.bash = function(_, _, command)
    local file = io.popen(command, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

M.same = function(index)
    return f(function(args)
        return args[1]
    end, { index })
end

return M