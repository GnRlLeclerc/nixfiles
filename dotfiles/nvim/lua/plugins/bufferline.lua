return {
  lazy = true, -- Disable loading for now, as I don't use it
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require('bufferline')

    bufferline.setup({
      options = {
        style_preset = { bufferline.style_preset.no_italic, bufferline.style_preset.no_bold },
        separator_style = { '', '' }, -- No separators
        indicator = { style = 'none' },
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(_, _, diagnostics_dict, _)
          local s = ' '
          for e, n in pairs(diagnostics_dict) do
            local sym = e == 'error' and 'E ' or (e == 'warning' and 'W ' or 'I ') -- Use letters instead of icons for spacing
            s = s .. n .. sym
          end
          return s
        end,
        offsets = {
          filetype = 'neo-tree',
          text = 'Neo Tree',
          separator = true,
          text_align = 'left',
        },
      },
    })

    -- Keymaps
    vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
    vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
    vim.keymap.set('n', '<leader>bd', '<cmd>bd#<CR>', { desc = 'Delete buffer' })
  end,
}
