local function live_dict()
	require("fzf-lua").fzf_exec("cat ".. vim.env.HOME .. "/local/wordlist", {
		preview = "wn {} -over | fold",
		fzf_opts = { ['--preview-window'] = 'nohidden,right,80%' },
		-- @param selected: the selected entry or entries
		-- @param opts: fzf-lua caller/provider options
		-- @param line: originating buffer completed line
		-- @param col: originating cursor column location
		-- @return newline: will replace the current buffer line
		-- @return newcol?: optional, sets the new cursor column
		complete = function(selected, opts, line, col)
			local newline = line:sub(1, col) .. selected[1]
			-- set cursor to EOL, since `nvim_win_set_cursor`
			-- is 0-based we have to lower the col value by 1
			return newline, #newline - 1
		end
	})
end


local keymap = vim.keymap

-- Wonderful mapping
keymap.set("i", "<C-c>", "<esc>", { noremap = true })
vim.g.mapleader = " "

-- Keymap
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true })

-- Moving window
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
keymap.set("n", "<c-,>", "<C-w>5>", { noremap = true })
keymap.set("n", "<c-.>", "<C-w>5<", { noremap = true })

-- moving line
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keymap.set("n", "<leader>gs", ":Git<CR>", { noremap = true })
keymap.set("n", "<leader>gs", ":FloatermNew --height=0.95 --width=0.95 --wintype=float lazygit<CR>", { noremap = true })
keymap.set("n", "<leader>fm", vim.lsp.buf.format, { noremap = true })

-- Tagbar
keymap.set("n", "<F8>", ":TagbarToggle<CR>", { noremap = true })

-- Copy to system clipboard
keymap.set("n", "<leader>y", '"+y', { noremap = true })
keymap.set("v", "<leader>y", '"+y', { noremap = true })
keymap.set("n", "<leader>Y", 'gg"+yG', { noremap = true })

keymap.set("n", "<leader>n", ":NERDTreeToggle<CR>", { noremap = true })
keymap.set("n", "<leader>m", ":NERDTreeFind<CR>", { noremap = true })
keymap.set("n", "<leader>nr", ":NERDTreeRefreshRoot<CR>", { noremap = true })

keymap.set("c", "<F2>", "\\(.*\\)", { noremap = true })
keymap.set("i", "<c-x><c-l>", live_dict, { noremap = true })
