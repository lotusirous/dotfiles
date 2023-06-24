vim.o.background = "dark"

require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = false,
	italic = {
		strings = false, -- it is very weird for italic the string in python string since interpolation
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "hard", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {
		NormalFloat = { fg = "#f9f5d7", bg = "#32302f" },
	},
	dim_inactive = false,
	transparent_mode = true,
})

vim.cmd.colorscheme("gruvbox")

require("lualine").setup({
	options = {
		icons_enabled = false,
		component_separators = "|",
		section_separators = "",
		theme = "gruvbox-material",
	},
})
