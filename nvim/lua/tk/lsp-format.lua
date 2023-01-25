local extensions = {
    javascript = "js",
    javascriptreact = "jsx",
    json = "json",
    jsonc = "jsonc",
    markdown = "md",
    typescript = "ts",
    typescriptreact = "tsx",
}


local prettier = {
    tabWidth = function()
        return vim.opt.shiftwidth:get()
    end,
    singleQuote = true,
    trailingComma = "all",
    configPrecedence = "prefer-file",
    exclude = { "tsserver", "jsonls" },

}
require("lsp-format").setup {
    typescript = prettier,
    javascript = prettier,
    typescriptreact = prettier,
    javascriptreact = prettier,
    json = prettier,
    css = prettier,
    scss = prettier,
    html = prettier,
    yaml = {
        tabWidth = function()
            return vim.opt.shiftwidth:get()
        end,
        singleQuote = true,
        trailingComma = "all",
        configPrecedence = "prefer-file",
    },
    python = {
        lineLength = 120,
    },
    markdown = {
        ft = function()
            return extensions[vim.bo.filetype]
        end,
    },
    sh = {
        tabWidth = 4,
    },
}
