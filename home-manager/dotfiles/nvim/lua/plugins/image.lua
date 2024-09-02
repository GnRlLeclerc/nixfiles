return {
  '3rd/image.nvim',
  dependencies = { 'leafo/magick' },
  config = function()
    -- TODO: use new nix config to properly provide luarocks magick
    -- require('image').setup()
  end,
}
