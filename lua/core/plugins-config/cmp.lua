local cmp = require'cmp'
local luasnip = require("luasnip")


local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end


cmp.setup({
  snippet = {
  -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
},


mapping = cmp.mapping.preset.insert({

  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif check_backspace() then
      fallback()
    else
      fallback()
    end
    end, {
      "i",
      "s",
    }),

  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For vsnip users.
    { name = 'buffer' },
    { name = 'path' },
    }),


})

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("lspconfig")['clangd'].setup {
  capabilities = capabilities,
}

require("lspconfig")['pyright'].setup {
  capabilities = capabilities,
}

