return {
  'epwalsh/obsidian.nvim',
  version = '*', -- Use latest release
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    disable_frontmatter = true, -- Disable frontmatter formatting
    workspaces = {
      {
        name = 'All notes',
        path = '~/Notes',
      },
    },
  },
}
