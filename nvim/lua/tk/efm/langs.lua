local swiftformat = { formatCommand = "swiftformat", formatStdin = true }

-- for golang
local goimports = { formatCommand = "goimports", formatStdin = true }
local gofumpt = { formatCommand = "gofumpt", formatStdin = true }
local golangci_lint = {
	lintCommand = "golangci-lint run --enable staticcheck,errcheck",
	lintWorkspace = true,
	lintIgnoreExitCode = true,
	lintFormats = { "%f:%l:%c: %m" },
	lintSource = "golangci-lint",
}

-- for python
local black = { formatCommand = "black --fast -", formatStdin = true }
local isort = {
	formatCommand = "isort --stdout ${-l:lineLength} --profile black -",
	formatStdin = true,
}

local misspell = {
	lintCommand = "misspell",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
	lintSource = "misspell",
}

local json_jq = { formatCommand = "jq .", formatStdin = true }

local shellcheck = {
	lintCommand = "shellcheck -f gcc -x -",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
	lintSource = "shellcheck",
}

local shfmt = { formatCommand = "shfmt ${-i:tabWidth}" }


local deno_fmt_markdown = {
	formatCommand = "deno fmt - --ext md ${--options-line-width:lineLength}",
	formatStdin = true
}



local deno_fmt = {
	formatCommand = "deno fmt - --ext ${ft} ${--options-line-width:lineLength}",
	formatStdin = true
}


local deno_fmt_js = {
	formatCommand = "deno fmt - --ext js ${--options-line-width:lineLength}",
	formatStdin = true
}

local prettier = {
	formatCommand = ([[
		prettier
		${--tab-width:tabWidth}
		${--config-precedence:configPrecedence}
		${--single-quote:singleQuote}
		${--trailing-comma:trailingComma}
	]]):gsub("\n", ""),
}

local luafmt = { formatCommand = "lua-format -i", formatStdin = true }

-- You need to install npm i -g prettier prettier-plugin-solidity

local eslint = {
	lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m" },
	lintSource = "eslint",
}

-- format code inside the markdown code block.
local cbfmt = {
	formatCommand = "cbfmt --best-effort --stdin-filepath ${INPUT}",
	formatStdin = true,
}


local write_good = {
	lintCommand = "write-good --parse ${INPUT}",
	lintStdin = false,
	lintFormats = { "%f:%l:%c:%m", "%f:%l:%c %m", "%f: %l: %m" },
}

return {
	["="] = { misspell },
	go = { golangci_lint, goimports, gofumpt },
	python = { black, isort },
	json = { json_jq },
	javascript = { deno_fmt_js },
	markdown = { prettier, cbfmt },
	css = { prettier },
	html = { prettier },
	scss = { prettier },
	lua = { luafmt },
	swift = { swiftformat },
	sh = { shellcheck, shfmt },
}
