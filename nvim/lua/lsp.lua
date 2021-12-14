local sumneko_root_path = "/Users/gru-2019015/local/lsp/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

local capabilities = require("cmp_nvim_lsp").update_capabilities(
                         vim.lsp.protocol.make_client_capabilities())

local cmp = require "cmp"
local luasnip = require("luasnip")

cmp.setup({
    sources = {
        {name = "luasnip"}, {name = "path"},
        {name = "buffer", keyword_length = 4}, {name = "nvim_lsp"}
        -- {name = "nvim_lua"}
        -- {name = "look"}
    },
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(
            {behavior = cmp.SelectBehavior.Insert}),
        ["<C-p>"] = cmp.mapping.select_prev_item(
            {behavior = cmp.SelectBehavior.Insert}),
        ["<Down>"] = cmp.mapping.select_next_item(
            {behavior = cmp.SelectBehavior.Select}),
        ["<Up>"] = cmp.mapping.select_prev_item(
            {behavior = cmp.SelectBehavior.Select}),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        })
    },
    experimental = {
        native_menu = false -- I like the new menu better
    }
})

-- change the error icon
-- vim.lsp.handlers["textDocument/hover"] =
--     vim.lsp.with(vim.lsp.handlers.hover,
--                  {border = vim.g.floating_window_border_dark})

-- vim.lsp.handlers["textDocument/signatureHelp"] =
--     vim.lsp.with(vim.lsp.handlers.signature_help,
--                  {border = vim.g.floating_window_border_dark})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                   opts)
    buf_set_keymap("n", "<space>wa",
                   "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr",
                   "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl",
                   "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                   opts)
    buf_set_keymap("n", "<space>D",
                   "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",
                   opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e",
                   "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
                   opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
                   opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
                   opts)
    buf_set_keymap("n", "<space>q",
                   "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                   opts)
    buf_set_keymap("n", "<space>lr", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)

    -- Set autocommands conditional on server_capabilities
    -- higlight inline string
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end

    -- codelens show references
    if client.resolved_capabilities.code_lens then
        vim.cmd [[
        augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufWritePost,CursorHold <buffer> lua vim.lsp.codelens.refresh()
        augroup END
        ]]
    end

    -- enable format if the LSP server support it
    if client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.cmd [[augroup END]]
    end
end

-- require "lspconfig".pylsp.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     handlers = handlers,
--     flags = {debounce_text_changes = 150}
-- }

require"lspconfig".pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {debounce_text_changes = 150}
}

require"lspconfig".tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr) -- another tool will take care of this
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    flags = {debounce_text_changes = 150}
}

require"lspconfig".clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd", "--background-index", "--suggest-missing-includes",
        "--fallback-style=gnu", "--all-scopes-completion", "--clang-tidy",
        "--header-insertion=iwyu", "--completion-style=detailed"
    },
    root_dir = function() return vim.loop.cwd() end
}

require"lspconfig".gopls.setup {
    capabilities = capabilities,
    cmd = {"gopls", "serve"},
    on_attach = function(client, bufnr) -- another tool will take care of this
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    -- settings = {gopls = {codelenses = {test = true}}},
    settings = {
        gopls = {
            analyses = {unusedparams = true},
            codelenses = {test = true},
            staticcheck = true
        }
    },
    flags = {debounce_text_changes = 200}
}

-- https://github.com/redhat-developer/yaml-language-server
-- require "lspconfig".yamlls.setup {}

-- https://github.com/joe-re/sql-language-server
-- lspconfig.sqlls.setup {on_attach = on_attach}

-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
-- lspconfig.cssls.setup {on_attach = on_attach}

-- efm config
local efm_languages = require "efm_languages"
require"lspconfig".efm.setup {
    on_attach = on_attach,
    init_options = {
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true
    },
    root_dir = vim.loop.cwd,
    filetypes = vim.tbl_keys(efm_languages),
    settings = {languages = efm_languages, log_level = 1}
}

require"lspconfig".sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";")
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                }
            }
        }
    }
}

require"lspconfig".rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- https://github.com/rcjsuen/dockerfile-language-server-nodejs

require"lspconfig".dockerls.setup {on_attach = on_attach}
