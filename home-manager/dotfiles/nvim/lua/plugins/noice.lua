return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('notify').setup({
      background_colour = require('base16-colorscheme').colors.base00,
    })
    require('noice').setup({
      -- Disable Noice for LSP notifications (let fidget handle them)
      lsp = { progress = { enabled = false } },
      -- Filter out some messages
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
              { find = '%d fewer lines' },
              { find = '%d more lines' },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          opts = { skip = true },
        },
      },
    })

    -- Keymaps
    vim.keymap.set('n', '<leader>nn', ':Noice dismiss<CR>', { noremap = true, desc = 'Dismiss notification' })
  end,
}
