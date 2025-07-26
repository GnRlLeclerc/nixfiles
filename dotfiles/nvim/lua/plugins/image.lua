return {
  '3rd/image.nvim',
  dependencies = { 'leafo/magick' },
  config = function()
    require('image').setup()
  end,
}
