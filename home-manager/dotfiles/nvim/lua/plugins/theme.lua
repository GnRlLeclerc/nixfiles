return {
  'GnRlLeclerc/dynamic-catppuccin.nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'dynamic',
      transparent_background = true,
      integrations = {
        telescope = {
          style = 'nvchad',
        },
        noice = true,
        copilot_vim = true,
      },
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
