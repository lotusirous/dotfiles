local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end


local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup({
    sources = {
        { name = "nvim_lsp" }, { name = "path" }, { name = "luasnip" },
        { name = "buffer", keyword_length = 4 }
        -- {name = "nvim_lua"}
        -- {name = "look"}
    },
    sorting = {
        comparators = {
            cmp.config.compare.kind,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,


            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order
        }
    },
    snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
    -- completion = {
    --     keyword_pattern = [[\k\+]],
    --     -- Currently this doesn't work nicely under nvim-cmp, but coc.nvim actually
    --     -- does roughly the same. Taken from <https://github.com/timbedard/dotfiles/blob/089422aad4705e029d33729079ab5e685e2ebe1a/config/nvim/lua/plugins.lua#L316>
    --     -- keyword_length = 0;

    --     -- Use whatever I have configured in `nvim/plugin/completion.vim`.
    --     completeopt = vim.o.completeopt
    -- },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(
            { behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item(
            { behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping.select_next_item(
            { behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item(
            { behavior = cmp.SelectBehavior.Select }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" })
    },
    experimental = { native_menu = false, ghost_text = false }
})

