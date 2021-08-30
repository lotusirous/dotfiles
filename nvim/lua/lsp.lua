local sumneko_root_path = "~/local/lsp/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.codeLens = {dynamicRegistration = false}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}

-- change the error icon
-- local handlers = {
--     ["textDocument/publishDiagnostics"] = vim.lsp.with(
--         vim.lsp.diagnostic.on_publish_diagnostics,
--         {
--             signs = true,
--             underline = false,
--             update_in_insert = true,
--             virtual_text = {spacing = 4, prefix = "«"}
--         }
--     )
-- }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- Remove the following block because of compe in clangd does not work with
    -- omnifunc
    -- local function buf_set_option(...)
    --     vim.api.nvim_buf_set_option(bufnr, ...)
    -- end

    -- Enable completion triggered by <c-x><c-o>
    -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- Set autocommands conditional on server_capabilities
    -- higlight inline string
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
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

require "lspconfig".pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {debounce_text_changes = 150}
}

require "lspconfig".tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr) -- another tool will take care of this
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    flags = {debounce_text_changes = 150}
}

require "lspconfig".clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--all-scopes-completion",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed"
    },
    root_dir = function()
        return vim.loop.cwd()
    end
}

require "lspconfig".gopls.setup {
    capabilities = capabilities,
    cmd = {"gopls", "serve"},
    on_attach = function(client, bufnr) -- another tool will take care of this
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    settings = {
        gopls = {
            codelenses = {test = true}
        }
    },
    flags = {
        debounce_text_changes = 200
    }
}

-- https://github.com/redhat-developer/yaml-language-server
require "lspconfig".yamlls.setup {}

-- https://github.com/joe-re/sql-language-server
-- lspconfig.sqlls.setup {on_attach = on_attach}

-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
-- lspconfig.cssls.setup {on_attach = on_attach}

-- efm config
local efm_languages = require "efm_languages"
require "lspconfig".efm.setup {
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

require "lspconfig".sumneko_lua.setup {
    on_attach = on_attach,
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

require "lspconfig".rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
require "lspconfig".dockerls.setup {
    on_attach = on_attach
}
