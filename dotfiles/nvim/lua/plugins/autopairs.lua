return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- use opts = {} for passing setup options
  -- this is equivalent to setup({}) function
  config = function()
    require('nvim-autopairs').setup({})
    local npairs = require('nvim-autopairs')
    local Rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')

    -- Add * and _ matching for typst files
    npairs.add_rules({
      Rule('*', '*', 'typst'):with_move(cond.before_regex('\\*')),
      Rule('$', '$', 'typst'):with_move(cond.before_regex('$')),
      Rule('_', '_', 'typst'):with_move(function(opts)
        -- Need custom rule because regex does not work in _<word>_ situation
        return vim.api.nvim_get_current_line():sub(opts.col, opts.col) == '_'
      end),
    })
  end,
}
