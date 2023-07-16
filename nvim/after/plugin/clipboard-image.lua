local function paste_image()
	-- Check if the buffer is in normal mode and modifiable
	if vim.fn.mode() ~= "n" or not vim.bo.modifiable then
		vim.api.nvim_err_writeln("Cannot paste image. The buffer must be in normal mode and modifiable.")
		return
	end
	-- Get the current buffer name and path
	local buffer_path = vim.fn.expand("%:p:h")

	-- Generate the image file name using date and time
	local date_time = os.date("%Y%m%d_%H%M%S")
	local image_dir = string.format("%s/img", buffer_path)
	local image_file = string.format("%s/%s.png", image_dir, date_time)

	-- Check if the 'img' directory exists and create it if needed
	if vim.fn.isdirectory(image_dir) == 0 then
		vim.fn.mkdir(image_dir, "p")
		vim.api.nvim_echo({ { "Created 'img' directory.", "WarningMsg" } }, true, {})
	end

	-- Execute pngpaste command to save the image
	local cmd_paste = "pngpaste '%s' 2>&1"
	local command = string.format(cmd_paste, image_file)

	local handle = assert(io.popen(command))
	local result = handle:read("*a")
	local success, exit_status, _ = handle:close()
	if not success or exit_status ~= nil then
		vim.api.nvim_err_writeln("Failed to paste: " .. result)
		return
	end

	-- Insert the relative path to the current buffer
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	vim.fn.setpos(".", { 0, line, col })
	vim.api.nvim_command(string.format("normal! a![](img/%s.png) ", date_time))
	vim.api.nvim_command("startinsert!")
	vim.api.nvim_command("normal! F]") -- Move cursor inside the brackets
end

local keymap = vim.keymap
keymap.set("n", "<F10>", paste_image, { noremap = true })
