vim.o.cursorline = true
vim.opt.nu = true
vim.o.mouse = ""

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

vim.opt.undodir = vim.env.HOME .. "/.config/undodir"
vim.opt.undofile = true

-- Configure search options
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Enable NERDTree minimal UI
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowLineNumbers = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinSize = 60
-- spelling
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- better for reading a long message from diagnostic
vim.wo.linebreak = true

-- vim.opt.list = true
-- vim.opt.listchars = {
--     eol = "⤦",
--     tab = " │",
--     trail = "…",
--     lead = "·",
--     extends = "»",
--     precedes = "«"
-- }
vim.opt.list = true
vim.opt.listchars = { eol = "↵", tab = "⇥ ", trail = "⋅", extends = ">", precedes = "<" }

-- vim.opt.listchars:append({ trail = "⋅" })
-- vim.opt.listchars:append({ eol = "↴" })
-- vim.opt.listchars = {
-- 	-- eol = "¬",
-- 	lead = "⋅",
-- 	tab = "  ",
-- 	extends = "›", -- Alternatives: … »
-- 	precedes = "‹" -- Alternatives: … «
-- }
--
-- set grepprg
vim.api.nvim_set_option("grepprg", "rg --vimgrep --smart-case")

-- set grepformat
vim.api.nvim_set_option("grepformat", "%f:%l:%c:%m,%f:%l:%m")

vim.o.fillchars = [[eob: ,fold: ,foldopen:⌄,foldsep: ,foldclose:>]]
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
