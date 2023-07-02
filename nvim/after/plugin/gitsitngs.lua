local gitsigns = require("gitsigns")
local function on_attach(bufnr)
	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gitsigns.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	map("n", "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gitsigns.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	-- Actions
	map("n", "<leader>hs", gitsigns.stage_hunk)
	map("n", "<leader>hr", gitsigns.reset_hunk)
	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end)
	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end)
	map("n", "<leader>hS", gitsigns.stage_buffer)
	map("n", "<leader>hu", gitsigns.undo_stage_hunk)
	map("n", "<leader>hR", gitsigns.reset_buffer)
	map("n", "<leader>hi", gitsigns.preview_hunk_inline)
	map("n", "<leader>hb", function()
		gitsigns.blame_line({ full = true })
	end)
	map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
	-- map("n", "<leader>hd", gitsigns.diffthis)
	-- map("n", "<leader>hD", function()
	-- 	gitsigns.diffthis("~")
	-- end)
	map("n", "<leader>td", gitsigns.toggle_deleted)

	-- Toggles
	map("n", "<leader>tb", gitsigns.toggle_current_line_blame)

	-- Have no idea what it is
	-- map("n", "<leader>td", gitsigns.toggle_deleted)
	-- map("n", "<leader>tw", gitsigns.toggle_word_diff)

	map("n", "<leader>hq", gitsigns.setqflist)
end

gitsigns.setup({
	max_file_length = 100000,
	on_attach = on_attach,
	update_debounce = 50,
	preview_config = {
		border = "rounded",
	},
	_threaded_diff = true,

	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})
