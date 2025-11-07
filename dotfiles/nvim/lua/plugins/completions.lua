-- Completions and snippets configuration
return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',

  opts = {
    keymap = {
      preset = 'none',

      -- Completion menu
      ['<C-Space>'] = { 'show' },
      ['<CR>'] = { 'accept', 'fallback' },

      -- Navigate completions
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path' },

      per_filetype = {
        -- No completion sources for commit messages
        gitcommit = {},
        markdown = {},
      },
      -- https://github.com/Saghen/blink.cmp/discussions/564
    },
  },
}
