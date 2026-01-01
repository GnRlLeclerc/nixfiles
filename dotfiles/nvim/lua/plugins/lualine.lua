return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'AndreM222/copilot-lualine' },

  event = 'BufRead', -- Triggers Copilot loading when a buffer is read, disabling it in the startup screen
  config = function()
    require('lualine').setup({
      extensions = { 'neo-tree' },
      options = {
        theme = 'catppuccin',
        section_separators = { left = '', right = '' },
        -- ignore_focus = { "neo-tree" },
      },
      sections = {
        -- Left part of lualine
        lualine_a = { 'mode' },
        lualine_b = {
          'filetype',
          { 'filename', icon = { '󰑃', align = 'right' } },
        },
        lualine_c = { 'branch', 'diff' },

        -- Right part of lualine
        lualine_x = {},
        lualine_y = { 'diagnostics', 'copilot' },
        lualine_z = { { 'progress', icon = '' }, 'location' },
      },
    })
  end,
}
