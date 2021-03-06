-- some example: https://github.com/tomaskallup/dotfiles/blob/master/nvim/lua/plugins/nvim-lspconfig.lua
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua
local lspconfig = require "lspconfig"

vim.fn.sign_define("LspDiagnosticsSignError", {
    texthl = "LspDiagnosticsSignError",
    text = "😡",
    numhl = "LspDiagnosticsSignError"
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
    texthl = "LspDiagnosticsSignWarning",
    text = "⚠️",
    numhl = "LspDiagnosticsSignWarning"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
    texthl = "LspDiagnosticsSignHint",
    text = "💡",
    numhl = "LspDiagnosticsSignHint"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
    texthl = "LspDiagnosticsSignInformation",
    text = "📙",
    numhl = "LspDiagnosticsSignInformation"
})

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<space>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                   opts)
    buf_set_keymap('n', '<space>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
                   opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
                   opts)
    buf_set_keymap('n', '<space>q',
                   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                       opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>f",
                       "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)

    end

    -- format on save
    if client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.cmd [[augroup END]]
    end
end

local lua_settings = {
    Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';')
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'}
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
            }
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {enable = false}
    }
}

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport =
        {properties = {'documentation', 'detail', 'additionalTextEdits'}}

    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,
        handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    signs = true,
                    underline = false,
                    update_in_insert = true,
                    virtual_text = {spacing = 4, prefix = '«'}
                })
        }
    }
end

-- EFM configuration language
local function make_efm_languages()
    local vint = {
        lintCommand = "vint -", -- requires https://github.com/Vimjas/vint
        lintStdin = true,
        lintFormats = {"%f:%l:%c: %m"},
        lintSource = "vint"
    }

    local black = {formatCommand = "black --fast -", formatStdin = true}

    local isort = {
        formatCommand = "isort --stdout --profile black -",
        formatStdin = true
    }

    local mypy = {
        lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
        lintFormats = {
            "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m",
            "%f:%l:%c: %tote: %m"
        },
        lintSource = "mypy"
    }

    local misspell = {
        lintCommand = "misspell",
        lintIgnoreExitCode = true,
        lintStdin = true,
        lintFormats = {"%f:%l:%c: %m"},
        lintSource = "misspell"
    }

    local golint = {
        lintCommand = "golangci-lint",
        lintIgnoreExitCode = true
        -- lintFormats = {"%f:%l:%c: %m"},
        -- lintSource = "golint"
    }

    local goimports = {formatCommand = "goimports", formatStdin = true}

    local json_jq = {formatCommand = "jq .", formatStdin = true}

    local rustfmt = {formatCommand = "rustfmt", formatStdin = true}

    local shellcheck = {
        lintCommand = "shellcheck -f gcc -x -",
        lintStdin = true,
        lintFormats = {
            "%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m",
            "%f=%l:%c: %tote: %m"
        },
        lintSource = "shellcheck"
    }
    local prettier = {
        formatCommand = "prettier --stdin-filepath ${INPUT}",
        formatStdin = true
    }

    local luafmt = {
        formatCommand = "lua-format -i", -- npm install lua-fmt
        formatStdin = true
    }

    -- Support languages
    return {
        ["="] = {misspell},
        vim = {vint},
        -- go = {golint, goimports},
        python = {black, isort, mypy},
        json = {json_jq},
        -- rust = {rustfmt},
        lua = {luafmt},
        markdown = {prettier},
        html = {prettier},
        scss = {prettier},
        css = {prettier},
        yaml = {prettier},
        sh = {shellcheck}
    }
end

local function setup_server()

    local servers = {
        "gopls", "pyright", "rust_analyzer", "clangd", "tsserver", "efm",
        "sumneko_lua"
    }

    for _, s in pairs(servers) do
        -- this is a share configuration for all server
        local c = make_config()

        if s == "sumneko_lua" then
            local sumneko_root_path =
                "/Users/gru-2019015/local/lsp/lua-language-server"
            local sumneko_binary =
                "/Users/gru-2019015/local/lsp/lua-language-server/bin/lua-language-server"
            c.cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
            c.settings = lua_settings
        end
        -- custom gopls setting
        if s == "gopls" then
            c.settings = {
                gopls = {analyses = {unusedparams = true}, staticcheck = true}
            }
            c.init_options = {completeUnimported = true}
        end

        if s == "pyright" then
            c.settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true
                    }
                }
            }
            c.init_options = {usePlaceholders = true, completeUnimported = true}
        end

        if s == "efm" then
            languages = make_efm_languages()
            c.init_options = {
                documentFormatting = true,
                codeAction = true,
                documentSymbol = true,
                hover = true
            }
            c.filetypes = vim.tbl_keys(languages)
            c.settings = {
                rootMarkers = {".git/"},
                log_level = 1,
                log_file = "~/efm.log",
                languages = languages
            }
        end

        lspconfig[s].setup(c)
    end

end

local function init() setup_server() end

return {init = init}
