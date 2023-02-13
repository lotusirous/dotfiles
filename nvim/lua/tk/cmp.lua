local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

-- local check_backspace = function()
--     local col = vim.fn.col "." - 1
--     return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

local types = require("cmp.types")

local priority_map = {
    [types.lsp.CompletionItemKind.EnumMember] = 1,
    [types.lsp.CompletionItemKind.Variable] = 2,
    [types.lsp.CompletionItemKind.Text] = 100,
}

local kindCompare = function(entry1, entry2)
	local kind1 = entry1:get_kind()
	local kind2 = entry2:get_kind()
	kind1 = priority_map[kind1] or kind1
	kind2 = priority_map[kind2] or kind2
	if kind1 ~= kind2 then
		if kind1 == types.lsp.CompletionItemKind.Snippet then
			return true
		end
		if kind2 == types.lsp.CompletionItemKind.Snippet then
			return false
		end
		local diff = kind1 - kind2
		if diff < 0 then
			return true
		elseif diff > 0 then
			return false
		end
	end
end

local underscore_compare = function(entry1, entry2)
	local _, entry1_under = entry1.completion_item.label:find "^_+"
	local _, entry2_under = entry2.completion_item.label:find "^_+"
	entry1_under = entry1_under or 0
	entry2_under = entry2_under or 0
	if entry1_under > entry2_under then
		return false
	elseif entry1_under < entry2_under then
		return true
	end
end

cmp.setup({
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 4 },
		{ name = "path" },
		{ name = "nvim_lsp_signature_help" },

		-- {name = "look"}
	},
	sorting = {
		priority_weight = 100,
		comparators = {
			kindCompare,
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			underscore_compare,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<tab>"] = cmp.config.disable,
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- The tab key is difficult to navigate between the next snippet and completion.
		-- So, I have to turn it off. You can use ctl-K instead
	},
	experimental = { native_menu = false, ghost_text = false },
})
