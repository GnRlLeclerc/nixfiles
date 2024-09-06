return {
  'max397574/startup.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    require('startup').setup({
      -- Section 1: ASCII Art
      section_1 = {
        type = 'text',
        align = 'center',
        fold_section = false,
        title = 'Startup Screen',
        content = {
          '    ◯                                                               ',
          '    ╰────███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗─◯ ╭───◯ ',
          ' ◯─╮  ◯──████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║───╯     ',
          '   ╰─────██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║───◯     ',
          '   ◯─────██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║──◯      ',
          '    ╭────██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║─────╮   ',
          '    │    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝     ◯   ',
          '◯───╯    ◯───┬───┬─┬─┬────┬─┬─┬─┬─────┬─────┬─┬────┬────┬─◯         ',
          '            ◯╯   ◯ │ ◯   ◯┤ │ ◯ │     ╰◯    │ │    ├◯   ◯           ',
          '                   ◯      │ ◯   ├◯         ◯┤ ◯    ◯                ',
          '                         ◯┤     ◯           ◯                       ',
          '                          ◯                                         ',
        },
        highlight = 'Keyword',
        margin = 5,
      },

      -- Section 2: Buttons
      section_2 = {
        type = 'mapping',
        align = 'center',
        fold_section = false,
        title = 'Actions',
        content = {
          { '  Find file', '<cmd>Telescope find_files<CR>', 'LDR fd' },
          { '  Find word', '<cmd>Telescope live_grep<CR>', 'LDR fg' },
          { '  File tree', '<cmd>NvimTreeToggle<CR>', 'LDR b' },
          { '󰂖  Plugins', '<cmd>Lazy<CR>', 'p' },
          { '󰅚  Quit', ':qa<CR>', 'q' },
        },
        highlight = 'Function',
      },

      -- Section 3: Info
      section_3 = {
        type = 'text',
        align = 'center',
        fold_section = false,
        content = function()
          return {
            string.format(
              '󰂖 %d  %s %d.%d.%d  %s',
              #vim.tbl_keys(require('lazy').plugins()),
              vim.fn.has('win32') == 1 and '' or '',
              vim.version().major,
              vim.version().minor,
              vim.version().patch,
              os.date(' %d-%m-%Y   %H:%M:%S')
            ),
          }
        end,
        highlight = 'Special',
        margin = 5,
      },

      options = {
        mapping_keys = true, -- Display mappings
        cursor_column = 0.5, -- Centered cursor
        after = function()
          -- Auto commands for disabling status and tablines
          vim.api.nvim_create_autocmd('User', {
            pattern = 'StartupDone',
            callback = function()
              vim.go.laststatus = 0
              vim.opt.showtabline = 0
            end,
          })
          vim.api.nvim_create_autocmd('BufUnload', {
            buffer = 0,
            callback = function()
              vim.go.laststatus = 3
            end,
          })
        end,
        empty_lines_between_mappings = true, -- Space between mappings
        disable_statuslines = true, -- Disable status, buffer, and tablines
        paddings = { 3, 2, 2 }, -- Padding for each section
      },

      colors = {
        background = '#1f2227', -- Background color
      },

      parts = { 'section_1', 'section_2', 'section_3' }, -- Define section order
    })
  end,
}
