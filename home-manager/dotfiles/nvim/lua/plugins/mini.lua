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
      require('mini.pairs').setup()
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
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
