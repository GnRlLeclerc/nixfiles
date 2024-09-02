return {
  'GnRlLeclerc/dynamic-base16.nvim',
  lazy = false,
  config = function()
    require('dynamic-base16').setup({
      module = 'base16_colors',
      transparent = true,
      watch = true,
    })
  end,
}
