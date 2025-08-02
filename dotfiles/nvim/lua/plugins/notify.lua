return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup({
      background_colour = require('catppuccin.palettes').get_palette('dynamic').base,
      enabled = false,
      stages = 'fade',
      timeout = 5000,
    })
  end,
}
