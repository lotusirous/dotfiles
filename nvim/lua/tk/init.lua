vim.loader.enable()
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

require("tk.plugins")
require("tk.sets")
require("tk.remap")
require("tk.colorscheme")