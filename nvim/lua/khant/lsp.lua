-- some example: https://github.com/tomaskallup/dotfiles/blob/master/nvim/lua/plugins/nvim-lspconfig.lua
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua
local lspconfig = require "lspconfig"

-- local function documentHighlight(client, bufnr)
--     -- Set autocommands conditional on server_capabilities
--     if client.resolved_capabilities.document_highlight then
--         vim.api.nvim_exec(
--             [[
--       hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
--       hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
--       hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
--             false
--         )
--     end
-- end
-- local lsp_config = {}

-- function lsp_config.common_on_attach(client, bufnr)
--     documentHighlight(client, bufnr)
-- end

-- allow lsp to auto complete functiona and properties
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport =
    {properties = {"documentation", "detail", "additionalTextEdits"}}

local function lsp_map(mode, left_side, right_side)
    vim.api
        .nvim_buf_set_keymap(0, mode, left_side, right_side, {noremap = true})
end

local function default_on_attach(client)
    print("Attaching to " .. client.name)
    if client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.cmd [[augroup END]]
    end

    lsp_map("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
    lsp_map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
    lsp_map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
    -- lsp_map("n", "gw", ":lua vim.lsp.buf.document_symbol()<CR>")
    -- lsp_map("n", "gW", ":lua vim.lsp.buf.workspace_symbol()<CR>")
    lsp_map("n", "gr", ":lua vim.lsp.buf.references()<CR>")
    lsp_map("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>")
    lsp_map("n", "K", ":lua vim.lsp.buf.hover()<CR>")
    lsp_map("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<CR>")
    lsp_map("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>")
    lsp_map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
    lsp_map("n", "[d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
    lsp_map("n", "]d", ":lua vim.lsp.diagnostic.goto_next()<CR>")

end

local default_config = {
    on_attach = default_on_attach,
    capabilities = capabilities
}

lspconfig.gopls.setup({
    on_attach = default_on_attach,
    capabilities = capabilities,
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
    init_options = {usePlaceholders = true, completeUnimported = true}
})

lspconfig.tsserver.setup(default_config)

lspconfig.pyright.setup({
    on_attach = default_on_attach,
    capabilities = capabilities,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {signs = true, underline = true, update_in_insert = true})
    },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "strict",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true
            }
        }
    },
    init_options = {usePlaceholders = true, completeUnimported = true}
})

lspconfig.rust_analyzer.setup(default_config)

-- EFM configuration language
local vint = {
    lintCommand = "vint -",
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
        "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"
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
    lintCommand = "golint",
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintSource = "golint"
}

local goimports = {formatCommand = "goimports", formatStdin = true}

local json_jq = {formatCommand = "jq .", formatStdin = true}

local rustfmt = {formatCommand = "rustfmt", formatStdin = true}

local shellcheck = {
    lintCommand = "shellcheck -f gcc -x -",
    lintStdin = true,
    lintFormats = {
        "%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m"
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
local languages = {
    ["="] = {misspell},
    vim = {vint},
    go = {golint, goimports},
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

lspconfig.efm.setup {
    on_attach = default_on_attach,
    init_options = {documentFormatting = true, codeAction = true},
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = {".git/"},
        log_level = 1,
        log_file = "~/efm.log",
        languages = languages
    }
}

lspconfig.clangd.setup {on_attach = default_on_attach}

