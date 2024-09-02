return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup({
      background_colour = '#000000',
      enabled = false,
      stages = 'fade',
      timeout = 5000,
    })
  end,
}
