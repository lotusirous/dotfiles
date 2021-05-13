" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/Users/gru-2019015/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/gru-2019015/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/gru-2019015/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/gru-2019015/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/gru-2019015/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  indentLine = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/lightline.vim"
  },
  ["lspcontainers.nvim"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/lspcontainers.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  nerdtree = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\nØ\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\vsource\1\0\6\vbuffer\2\nvsnip\2\tpath\2\rnvim_lua\2\rnvim_lsp\2\tcalc\2\1\0\f\18documentation\2\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\ndebug\1\18throttle_time\3P\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\19source_timeout\3»\1\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  rustfmt = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/rustfmt"
  },
  ["splitjoin.vim"] = {
    commands = { "SplitjoinSplit", "SplitjoinJoin" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/opt/splitjoin.vim"
  },
  tabular = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/tabular"
  },
  undotree = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-better-whitespace"] = {
    config = { "\27LJ\2\n◊\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0$let g:strip_whitelines_at_eof=1%let g:strip_whitespace_confirm=0%let g:strip_whitespace_on_save=1&let g:better_whitespace_enabled=1\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-go"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/vim-go"
  },
  ["vim-rfc"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/vim-rfc"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/gru-2019015/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  }
}

time("Defining packer_plugins", false)
-- Config for: gitsigns.nvim
time("Config for gitsigns.nvim", true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time("Config for gitsigns.nvim", false)
-- Config for: vim-better-whitespace
time("Config for vim-better-whitespace", true)
try_loadstring("\27LJ\2\n◊\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0$let g:strip_whitelines_at_eof=1%let g:strip_whitespace_confirm=0%let g:strip_whitespace_on_save=1&let g:better_whitespace_enabled=1\bcmd\bvim\0", "config", "vim-better-whitespace")
time("Config for vim-better-whitespace", false)
-- Config for: nvim-compe
time("Config for nvim-compe", true)
try_loadstring("\27LJ\2\nØ\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\vsource\1\0\6\vbuffer\2\nvsnip\2\tpath\2\rnvim_lua\2\rnvim_lsp\2\tcalc\2\1\0\f\18documentation\2\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\ndebug\1\18throttle_time\3P\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\19source_timeout\3»\1\nsetup\ncompe\frequire\0", "config", "nvim-compe")
time("Config for nvim-compe", false)

-- Command lazy-loads
time("Defining lazy-load commands", true)
vim.cmd [[command! -nargs=* -range -bang -complete=file SplitjoinJoin lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinJoin", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SplitjoinSplit lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinSplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time("Defining lazy-load commands", false)

if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
