-- Completions and snippets configuration

return {
  {
    'hrsh7th/cmp-nvim-lsp',
    event = 'BufRead',
  },
  {
    'L3MON4D3/LuaSnip',
    event = 'BufRead',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'onsails/lspkind.nvim',
    },
    event = 'BufRead',
    config = function()
      local cmp, lspkind = require('cmp'), require('lspkind')
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- Use luasnip for snippet expansion
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- Completion menu
          ['<C-Space>'] = cmp.mapping.complete(), -- Open the completion menu
          ['<C-e>'] = cmp.mapping.abort(), -- Dismiss the completion menu
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

          -- Navigate completions
          ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

          -- Scroll documentation
          ['<C-l>'] = cmp.mapping.scroll_docs(-4),
          ['<C-h>'] = cmp.mapping.scroll_docs(4),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
        formatting = {
          -- Use lspkind for the completions formatting
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 30,
            ellipsis_char = '...',
            show_labelDetails = true,
          }),
        },
      })

      -- Setup up vim-dadbod
      cmp.setup.filetype({ 'sql' }, {
        sources = {
          { name = 'vim-dadbod-completion' },
          { name = 'buffer' },
        },
      })
    end,
  },
}
