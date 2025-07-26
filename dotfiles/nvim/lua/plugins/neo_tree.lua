return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    -- Show / Hide the filesystem VSCode style
    {
      '<leader>a',
      ':Neotree filesystem reveal left toggle<CR>',
      { noremap = true, silent = true, desc = 'Toggle file tree' },
    },
    {
      '<C-b>',
      ':Neotree filesystem reveal left toggle<CR>',
      { noremap = true, silent = true, desc = 'Toggle file tree' },
    }, -- VSCode style
  },

  opts = {
    close_if_last_window = true,
    default_component_configs = {
      indent = {
        with_markers = false,
        indent_marker = '│',
        last_indent_marker = '╰',
        with_expanders = true,
      },
    },
    window = {
      mappings = {
        -- Convenient mappings for navigation with j-k
        ['h'] = 'toggle_node',
        ['l'] = 'close_all_subnodes',
      },
    },
    filesystem = {
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { '.git', 'venv', '.venv', 'node_modules', '__pycache__' },
      },
      follow_current_file = { enabled = true },
    },
  },
}
