return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '┃' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },

        on_attach = function(bufnr)
          -- Buffer keymaps
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, { noremap = true, desc = 'Stage hunk' })
          map('n', '<leader>hr', gitsigns.reset_hunk, { noremap = true, desc = 'Reset hunk' })
          map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { noremap = true, desc = 'Stage hunk' })
          map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { noremap = true, desc = 'Reset hunk' })
          map('n', '<leader>hS', gitsigns.stage_buffer, { noremap = true, desc = 'Stage buffer' })
          map('n', '<leader>hu', gitsigns.undo_stage_hunk, { noremap = true, desc = 'Undo stage hunk' })
          map('n', '<leader>hR', gitsigns.reset_buffer, { noremap = true, desc = 'Reset buffer' })
          map('n', '<leader>hp', gitsigns.preview_hunk, { noremap = true, desc = 'Preview hunk' })
          map('n', '<leader>hb', function()
            gitsigns.blame_line({ full = true })
          end, { noremap = true, desc = 'Blame line' })
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { noremap = true, desc = 'Toggle blame line' })
          map('n', '<leader>hd', gitsigns.diffthis, { noremap = true, desc = 'Diff this' })
          map('n', '<leader>hD', function()
            gitsigns.diffthis('~')
          end, { noremap = true, desc = 'Diff this (cached)' })
          map('n', '<leader>td', gitsigns.toggle_deleted, { noremap = true, desc = 'Toggle deleted' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { noremap = true, silent = true })
        end,
      })
    end,
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    keys = {
      '<leader>gg',
      '<leader>gc',
      '<leader>gp',
      '<leader>gP',
    },
    config = function()
      local neogit = require('neogit')
      local actions = require('diffview.actions')
      require('diffview').setup({
        -- Override file navigation to match my neo-tree keymaps
        keymaps = {
          file_panel = {
            { 'n', 'l', actions.close_fold, { desc = 'Collapse fold' } },
            { 'n', 'h', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          },
        },
        view = {
          merge_tool = {
            layout = 'diff3_mixed',
          },
        },
      })

      neogit.setup({
        disable_signs = true, -- Ufo + statuscol handle folding indicators
      })

      -- Key bindings
      vim.keymap.set('n', '<leader>gg', neogit.open, { silent = true, noremap = true })
      vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { silent = true, noremap = true })
      vim.keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { silent = true, noremap = true })
      vim.keymap.set('n', '<leader>gP', ':Neogit push<CR>', { silent = true, noremap = true })
    end,
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      '<leader>gw',
      '<leader>gW',
    },
    config = function()
      require('git-worktree').setup({})
      require('telescope').load_extension('git_worktree')

      vim.keymap.set(
        'n',
        '<Leader>gw',
        "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
        { silent = true, noremap = true, desc = 'Git worktrees' }
      )
      vim.keymap.set(
        'n',
        '<Leader>gW',
        "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
        { silent = true, noremap = true, desc = 'Create git worktree' }
      )
    end,
  },
}
