return {
  'crnvl96/lazydocker.nvim',
  cmd = 'LazyDocker',
  keys = { '<leader>ld' },
  config = function()
    require('lazydocker').setup()
    vim.keymap.set('n', '<leader>ld', ':LazyDocker<CR>', { noremap = true, silent = true, desc = 'LazyDocker' })
  end,
}
