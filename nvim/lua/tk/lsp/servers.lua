local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then return end

local on_attach = require("tk.lsp.handlers").on_attach
local capabilities = require("tk.lsp.handlers").capabilities

local efm_languages = require("tk.lsp.efm_languages")

local sumneko_root_path = "/Users/gru-2019015/local/lsp/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {debounce_text_changes = 150}
}

lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr) -- another tool will take care of this
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    flags = {debounce_text_changes = 150}
}

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd", "--offset-encoding=utf-16", "--background-index",
        "--suggest-missing-includes", "--fallback-style=gnu",
        "--all-scopes-completion", "--clang-tidy", "--header-insertion=iwyu",
        "--completion-style=detailed"
    },
    root_dir = function() return vim.loop.cwd() end
}

lspconfig.gopls.setup {
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
lspconfig.efm.setup {
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

lspconfig.sumneko_lua.setup {
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

lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.hls.setup {on_attach = on_attach, capabilities = capabilities}
-- https://github.com/rcjsuen/dockerfile-language-server-nodejs

lspconfig.dockerls.setup {on_attach = on_attach}
lspconfig.sourcekit.setup {on_attach = on_attach}
