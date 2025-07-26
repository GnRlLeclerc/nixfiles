return {
  'GnRlLeclerc/dynamic-catppuccin.nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'dynamic',
      integrations = {
        telescope = {
          style = 'nvchad',
        },
        noice = true,
      },
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
