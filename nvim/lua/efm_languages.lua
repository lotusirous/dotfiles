local black = {formatCommand = "black --fast -", formatStdin = true}

local goimports = {formatCommand = "goimports", formatStdin = true}

local golint = {
    lintCommand = "golint",
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintSource = "golint"
}

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
    lintCommand = "shellcheck -f gcc -x -",
    lintStdin = true,
    lintFormats = {
        "%f=%l:%c: %trror: %m",
        "%f=%l:%c: %tarning: %m",
        "%f=%l:%c: %tote: %m"
    },
    lintSource = "shellcheck"
}

local shfmt = {
    formatCommand = "shfmt ${-i:tabWidth}"
}

local prettier = {
    formatCommand = ([[
        prettier
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub(
        "\n",
        ""
    )
}

local luafmt = {
    formatCommand = "luafmt ${-i:tabWidth} --stdin",
    formatStdin = true
}

return {
    ["="] = {misspell},
    -- go = {golint, goimports},
    python = {black, isort},
    json = {json_jq},
    javascript = {prettier},
    html = {prettier},
    markdown = {prettier},
    css = {prettier},
    scss = {prettier},
    lua = {luafmt},
    sh = {shellcheck, shfmt}
}
