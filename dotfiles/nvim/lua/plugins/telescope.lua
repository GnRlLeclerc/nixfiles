-- Defer loading the Trouble plugin until it's actually needed
local function lazy_open_with_trouble(prompt_bufnr)
  require('trouble.sources.telescope').open(prompt_bufnr)
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      branch = '0.1.x',
      { 'nvim-lua/plenary.nvim' },
      -- C implementation of fzf for even faster fuzzy search
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true },
    },
    lazy = true,
    keys = { '<C-p>', '<space>fd', '<leader>fg', '<leader>ft', '<leader>/', '<leader>fb', '<leader>gb' },
    module = 'telescope',
    cmd = {
      'Telescope',
      'Telescope find_files',
      'Telescope live_grep',
      'Telescope git_files',
      'Telescope current_buffer_fuzzy_find',
      'Telescope buffers',
      'Telescope git_branches',
    },

    config = function()
      local telescope = require('telescope')

      telescope.setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
          fzf = {},
        },
        defaults = {
          mappings = {
            -- Open results with trouble
            i = { ['<c-t>'] = lazy_open_with_trouble },
            n = { ['<c-t>'] = lazy_open_with_trouble },
          },
          layout_strategy = 'vertical',
          layout_config = { width = 0.5 },
        },
      })

      -- Telescope keymaps
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<C-p>', builtin.find_files, { noremap = true, desc = 'Find files' }) -- Fuzzy find files with Ctrl + P (VSCode style)
      vim.keymap.set('n', '<space>fd', builtin.find_files, { noremap = true, desc = 'Find files' }) -- Fuzzy find files
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true, desc = 'Grep in files' }) -- Grep through the project with
      vim.keymap.set('n', '<leader>ft', builtin.git_files, { noremap = true, desc = 'Find git files' }) -- Fuzzy find versionned files
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { noremap = true, desc = 'Grep in buffer' }) -- Fuzzy find in the current file
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true, desc = 'Find buffers' }) -- Fuzzy find buffers
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { noremap = true, desc = 'Find git branches' }) -- Fuzzy find git branches

      pcall(telescope.load_extension, 'fzf') -- Load fzf native if available
      pcall(telescope.load_extension, 'ui-select') -- Load telescope ui select if available
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
}
