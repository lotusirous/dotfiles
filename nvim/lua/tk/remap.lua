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

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Keymap
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })


keymap.set("n", "<leader>gs", ":FloatermNew --height=0.95 --width=0.95 --name=lazygit lazygit<CR>")
-- RG result is better than Rg

keymap.set(
	"n",
	"<leader>sb",
	"vim.fn.system('stdsym -web | fzf --prompt \"Symbols> \" --preview \"go doc ' .. vim.fn.shellescape(vim.fn.expand('<cword>')) .. ' | sed s/#/./g\" --bind \"enter:execute('echo https://pkg.go.dev/{} | xargs open')\"')",
	{ noremap = true }
)

-- Easier Moving between splits
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
keymap.set("n", "<C-,>", "<C-w>5>", { noremap = true })
keymap.set("n", "<C-.>", "<C-w>5<", { noremap = true })

keymap.set("v", "<Tab>", ">gv", { noremap = true })
keymap.set("v", "<S-Tab>", ">gv", { noremap = true })

-- Tagbar
keymap.set("n", "<F8>", ":TagbarToggle<CR>", { noremap = true })

-- Copy to system clipboard
keymap.set("n", "<leader>y", '"+y', { noremap = true })
keymap.set("v", "<leader>y", '"+y', { noremap = true })
keymap.set("n", "<leader>Y", 'gg"+yG', { noremap = true })

keymap.set("n", "<leader>m", ":NERDTreeFind<CR>", { noremap = true })
keymap.set("n", "<leader>r", ":NERDTreeRefreshRoot<CR>", { noremap = true })

keymap.set("c", "<F2>", "\\(.*\\)", { noremap = true })
keymap.set("i", "<c-x><c-l>", live_dict, { noremap = true })
