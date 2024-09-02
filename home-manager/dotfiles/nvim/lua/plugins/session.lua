return {
  'rmagatti/auto-session',
  lazy = true, -- Do not use sessions
  config = function()
    require('auto-session').setup({

      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    })

    -- Keybindings
    vim.keymap.set('n', '<C-s>', require('auto-session.session-lens').search_session, {
      noremap = true,
      desc = 'Search session',
    })

    vim.keymap.set('n', '<leader>ss', require('auto-session.session-lens').search_session, {
      noremap = true,
      desc = 'Search session',
    })
  end,
}
