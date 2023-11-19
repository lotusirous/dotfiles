local M = {}

local required_programs = {
	{ name = "gopls", description = "gopls: The Go language server" },
	{ name = "gofumpt", description = "gofumpt: Enforce a stricter format than gofmt" },
	{ name = "gotags", description = "gotags: gotags is a ctags-compatible tag generator for Go" },
	{ name = "deno", description = "deno: A modern runtime for JavaScript and TypeScript" },
	{ name = "fzf", description = "fzf: is a general-purpose command-line fuzzy finder" },
	{ name = "bat", description = "bat: A cat(1) clone with wings" },
	{ name = "lazygit", description = "lazygit: simple terminal UI for git commands" },
	{ name = "mdbook", description = "mdbook: Create book from markdown files" },
	{ name = "plantuml", description = "plantuml: Draw UML diagrams" },
	{ name = "pngpaste", description = "pngpaste: Paste PNG into files" },
	{ name = "tsserver", description = "tsserver: Language Server Protocol implementation for TypeScript" },
	{ name = "gotests", description = "gotests: Generate Go test boilerplate" },
	{ name = "golangci-lint", description = "golangci-lint: Linters Runner" },
}

local function is_program_installed(program)
	local handle = assert(io.popen("command -v " .. program .. " 2>/dev/null"))
	local result = handle:read("*a")
	handle:close()
	return result ~= ""
end

local function check_program(program)
	if is_program_installed(program.name) then
		vim.health.ok(program.description .. " is installed")
	else
		vim.health.error(program.description .. " is not installed")
	end
end

M.check = function()
	vim.health.start("Check installed programs")
	for _, program in ipairs(required_programs) do
		check_program(program)
	end
end

return M
