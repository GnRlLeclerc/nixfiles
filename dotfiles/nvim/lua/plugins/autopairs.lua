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

    local ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=]

    -- NOTE: additional autopair rules for markdown and typst
    -- Quotes-like: only when enclosed in whitespaces so that
    -- it basically triggers only before typing a new word,
    -- and not when trying to enclose an existing word
    -- or close an existing quote.

    -- Add * and _ matching for typst files
    npairs.add_rules({
      Rule('*', '*', 'typst')
        :with_move(cond.after_regex('\\*', 1))
        :with_pair(cond.not_after_regex(ignored_next_char))
        :with_pair(cond.not_before_regex(ignored_next_char)),
      Rule('$', '$', 'typst')
        :with_move(cond.after_regex('$', 1))
        :with_pair(cond.not_after_regex(ignored_next_char))
        :with_pair(cond.not_before_regex(ignored_next_char)),
      Rule('_', '_', 'typst')
        :with_move(cond.after_regex('_', 1))
        :with_pair(cond.not_after_regex(ignored_next_char))
        :with_pair(cond.not_before_regex(ignored_next_char)),
    })

    -- Add ** and _ matching for markdown files
    npairs.add_rules({
      Rule('**', '**', 'markdown')
        :with_move(cond.after_regex('\\*\\*', 2))
        :with_pair(cond.not_after_regex(ignored_next_char))
        :with_pair(cond.not_before_regex(ignored_next_char)),
      Rule('_', '_', 'markdown')
        :with_move(cond.after_regex('_', 1))
        :with_pair(cond.not_after_regex(ignored_next_char))
        :with_pair(cond.not_before_regex(ignored_next_char)),
    })
  end,
}
