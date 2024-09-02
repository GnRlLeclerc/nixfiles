-- Linter config

return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',

  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      -- Add linters here when I need them
    }

    -- Lint after file save
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
