require("mason").setup()
require("mason-lspconfig").setup({
  -- angularls must be installed together in oder to run the angularls
  ensure_installed = { "lua_ls", "angularls", "tsserver", "gopls" }
})

local lsp = require('lsp-zero').preset({})

-- enable folding by lsp server
lsp.set_server_config({
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
    }
  }
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { 'javascript', 'typescript', 'lua', 'go', 'markdown', 'python', 'json' },
  }
})

lsp.setup()



local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Replace these with the tools you have installed
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "typescript", "css", "html" },
      exclude_filetypes = { "markdown" }
    }),

    null_ls.builtins.formatting.jq.with({
      filetypes = { "json" }
    }),
    null_ls.builtins.formatting.deno_fmt.with({
      filetypes = { "markdown" }
    }),
    -- python
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    -- golang
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofumpt,

    null_ls.builtins.diagnostics.golangci_lint,

    -- for angular
    require("typescript.extensions.null-ls.code-actions"),
    -- null_ls.builtins.diagnostics.eslint_d.with({
    --   filetypes = {"javascript", "typescript"}
    -- }),
  }
})

require('lsp-zero').extend_cmp()
local cmp = require('cmp')
local ls = require('luasnip')
local cmp_action = require('lsp-zero.cmp').action()
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
    {name = 'nvim_lsp_signature_help'},
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-l>'] = function ()
      if ls.choice_active() then ls.change_choice(1) end
    end,
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item(cmp_select_opts)
      else
        cmp.complete()
      end
    end),
    ['<CR>'] = function(fallback)
      if cmp.visible() then
        cmp.mapping.confirm({ select = true })(fallback)
      else
        return fallback()
      end
    end,
  },

})
