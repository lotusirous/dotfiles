local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()


local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup(
    {
        sources = {
            {name = "luasnip"},
            {name = "path"},
            {name = "buffer", keyword_length = 4},
            {name = "nvim_lsp"}
            -- {name = "nvim_lua"}
            -- {name = "look"}
        },
        snippet = {expand = function(args)
                luasnip.lsp_expand(args.body)
            end},
        mapping = {
            ["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
            ["<C-p>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
            ["<Down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
            ["<Up>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm {select = true},
            ["<Tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end,
                {"i", "s"}
            )
        },
        experimental = {
            native_menu = false
        }
    }
)
