local function init()
    local plugins = {
        'packer', 'gruvbox', 'lsp', 'go', 'compe', 'nvim_autopairs', 'nerdtree',
        'snippets', 'hardtime'
        -- 'indent'
    }
    for _, plug in ipairs(plugins) do
        require(string.format('plugins.%s', plug)).init()
    end
end

return {init = init}
