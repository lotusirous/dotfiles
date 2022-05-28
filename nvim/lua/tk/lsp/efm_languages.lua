local swiftformat = {formatCommand = "swiftformat", formatStdin = true}

-- for golang
local goimports = {formatCommand = "goimports", formatStdin = true}
local gofumpt = {formatCommand = "gofumpt", formatStdin = true}
local golint = {
    lintCommand = "golint",
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintSource = "golint"
}
local golangci_lint = {
    lintCommand = "golangci-lint run --fast",
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintSource = "golangci-lint"
}

-- for python
local black = {formatCommand = "black --fast -", formatStdin = true}
local isort = {
    formatCommand = "isort --stdout --profile black -",
    formatStdin = true
}

local misspell = {
    lintCommand = "misspell",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintSource = "misspell"
}

local json_jq = {formatCommand = "jq .", formatStdin = true}

local shellcheck = {
    lintCommand = "shellcheck -f gcc -x ",
    lintFormats = {
        "%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m"
    },
    lintSource = "shellcheck"
}

local shfmt = {formatCommand = "shfmt ${-i:tabWidth}"}

local prettier_html = {
    formatCommand = ([[
        prettier
        --parser html
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub("\n", "")
}

local prettier = {
    formatCommand = ([[
        prettier
        ${--tab-width:tabWidth}
        ${--config-precedence:configPrecedence}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub("\n", "")
}

local luafmt = {formatCommand = "lua-format -i", formatStdin = true}

-- You need to install npm i -g prettier prettier-plugin-solidity


local eslint = {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
    lintSource = "eslint"
}

local xmllint = {
    lintCommand = "xmllint --format ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
    lintSource = "eslint"
}

local markdown_lint = {
    lintCommand = "markdownlint -s",
    lintStdin = true,
    lintFormats = {"%f:%l %m", "%f:%l:%c %m", "%f: %l: %m"}
}

local write_good = {
    lintCommand = "write-good --parse ${INPUT}",
    lintStdin = false,
    lintFormats = {"%f:%l:%c:%m", "%f:%l:%c %m", "%f: %l: %m"}
}

return {
    ["="] = {misspell},
    go = {golint, golangci_lint, goimports, gofumpt},
    python = {black, isort},
    json = {json_jq},
    javascript = {prettier, eslint},
    html = {prettier_html},
    markdown = {prettier, write_good, markdown_lint},
    css = {prettier},
    scss = {prettier},
    lua = {luafmt},
    xml = {xmllint},
    swift = {swiftformat},
    solidity = {prettier},
    sh = {shellcheck, shfmt}
}
