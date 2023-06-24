-- paste the image in the relative path of the current buffer

local function get_img_dir()
	local root = vim.fn.getcwd()
	local mkdocs_config = root .. "/mkdocs.yml"
	local is_mkdocs_root = vim.fn.filereadable(mkdocs_config) == 1
	if is_mkdocs_root then
		return root .. "/docs/img"
	end
	return "img"
end

require("clipboard-image").setup({
	img_dir = get_img_dir(),
})
