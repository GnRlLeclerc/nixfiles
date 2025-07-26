return {
  'zbirenbaum/copilot.lua',
  event = 'BufRead', -- Triggers Copilot loading when a buffer is read
  config = function()
    require('copilot').setup({
      -- Configure Copilot to use tabs for completion
      suggestion = { accept = false, auto_trigger = true },
    })

    vim.keymap.set('i', '<Tab>', function()
      if require('copilot.suggestion').is_visible() then
        require('copilot.suggestion').accept()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
      end
    end, {
      silent = true,
    })
  end,
}
