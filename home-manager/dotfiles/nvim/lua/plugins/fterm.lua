return {
  'numToStr/FTerm.nvim',
  lazy = true,
  keys = {
    { '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true } },
  },
  config = function()
    require('FTerm').setup({})

    vim.keymap.set(
      'n',
      '<C-t>',
      "<CMD>lua require('FTerm').toggle()<CR>",
      { noremap = true, desc = 'Open floating terminal' }
    )
  end,
}
