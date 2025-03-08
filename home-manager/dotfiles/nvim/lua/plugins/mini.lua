return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    dependencies = {
      { 'echasnovski/mini.indentscope', version = '*' },
      { 'echasnovski/mini.pairs', version = '*' },
      { 'echasnovski/mini.comment', version = '*' },
      { 'echasnovski/mini.surround', version = '*' },
    },

    config = function()
      -- Custom pair matching, matches pairs of characters where:
      -- 1st char is not a backslash (avoid autocomplete after escape chars)
      -- 2nd chr is a space, tab, newline, comma, end of line, or closing element
      local pairs_regex = '[^\\][ \t\n)}%],]'

      require('mini.pairs').setup({
        mappings = {
          ['('] = { action = 'open', pair = '()', neigh_pattern = pairs_regex },
          ['['] = { action = 'open', pair = '[]', neigh_pattern = pairs_regex },
          ['{'] = { action = 'open', pair = '{}', neigh_pattern = pairs_regex },

          [')'] = { action = 'close', pair = '()', neigh_pattern = pairs_regex },
          [']'] = { action = 'close', pair = '[]', neigh_pattern = pairs_regex },
          ['}'] = { action = 'close', pair = '{}', neigh_pattern = pairs_regex },

          ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = pairs_regex, register = { cr = false } },
          ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = pairs_regex, register = { cr = false } },
          -- Apostrophe: not after letters
          ["'"] = {
            action = 'closeopen',
            pair = "''",
            neigh_pattern = '[^%a\\][ \t\n)}%],]',
            register = { cr = false },
          },
        },
      })

      require('mini.surround').setup()
      require('mini.comment').setup()
      require('mini.indentscope').setup({
        symbol = '│',
        options = { try_as_border = true },
      })
      -- Deactivate indentscope for specific :
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'trouble',
          'neo-tree',
          'lazy',
          'mason',
          'NeogitStatus',
          'FTerm',
          'markdown',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
