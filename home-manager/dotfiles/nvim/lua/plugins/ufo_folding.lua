return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  event = 'VeryLazy',

  config = function()
    -- Custom handler to display the number of lines in a fold
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (' 󰁂 %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end

    local ufo = require('ufo')
    ufo.setup({
      fold_virt_text_handler = handler,
      -- Define code portions that are automatically folded
      close_fold_kinds_for_ft = {
        typescript = {
          'imports',
        },
      },
    })

    -- Folding
    vim.keymap.set('n', 'f', 'za', { noremap = true, silent = true, desc = 'Toggle fold' }) -- Toggle folding with the f key
    vim.keymap.set('n', 'zf', ufo.openAllFolds, { noremap = true, silent = true, desc = 'Open all folds' })
    vim.keymap.set('n', 'zF', ufo.closeAllFolds, { noremap = true, silent = true, desc = 'Close all folds' })

    -- Disable folding in the neo-tree pane
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'neo-tree' },
      callback = function()
        require('ufo').detach()
        vim.opt_local.foldenable = false
        vim.wo.foldcolumn = '0'
      end,
    })
  end,
}
