return {
  'folke/todo-comments.nvim',
  event = 'BufRead', -- Triggers Copilot loading when a buffer is read
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
}
