-- Create the options for a button
-- @param shortcut string
-- @param text string
-- @param keybind string (optional)
-- @return table
local function button(shortcut, text, keybind)
  local opts = {
    cursor = 3,
    align_shortcut = 'right',
    hl_shortcut = 'Identifier', -- Shortcut highlight group
    hl = 'Function', -- Text highlight group
    width = 70, -- Horizontal spacing
    position = 'center',
    shortcut = shortcut,
  }

  if keybind then
    local keybind_opts = { noremap = true, silent = true, nowait = true }
    opts.keymap = { 'n', shortcut, keybind, keybind_opts }
  end
  return { type = 'button', val = text, opts = opts }
end

return {
  'goolord/alpha-nvim',
  config = function()
    local alpha = require('alpha')

    alpha.setup({
      layout = {
        { type = 'padding', val = 3 },
        {
          type = 'text',
          val = {
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
          opts = { position = 'center', hl = 'Keyword' },
        },
        { type = 'padding', val = 2 },
        {
          type = 'group',
          val = {
            -- button("LDR to", "󰈢  Recently opened files"), -- TODO
            button('LDR fd', '  Find file'),
            button('LDR fg', '  Find word'),
            button('LDR b', '  File tree'),
            -- button("LDR ts", "  Open session"), -- TODO
            button('p', '󰂖  Plugins', '<Cmd>Lazy<CR>'),
            button('q', '󰅚  Quit', ':qa<CR>'),
          },
          opts = { spacing = 1 },
        },
        { type = 'padding', val = 2 },
        {
          type = 'text',
          val = string.format(
            '󰂖 %d  %s %d.%d.%d  %s',
            #vim.tbl_keys(require('lazy').plugins()), -- Plugins
            vim.fn.has('win32') == 1 and '' or '', -- Platform
            vim.version().major, -- Version
            vim.version().minor,
            vim.version().patch,
            os.date(' %d-%m-%Y   %H:%M:%S') -- Datetime
          ),
          opts = { hl = 'Special', position = 'center' },
        },
      },
      opts = {
        setup = function()
          vim.api.nvim_create_autocmd('User', {
            pattern = 'AlphaReady',
            desc = 'Disable status and tabline for alpha',
            callback = function()
              vim.go.laststatus = 0
              vim.opt.showtabline = 0
            end,
          })
          vim.api.nvim_create_autocmd('BufUnload', {
            buffer = 0,
            desc = 'Enable status and tabline after alpha',
            callback = function()
              vim.go.laststatus = 3
              -- vim.opt.showtabline = 2 -- Keep tabline hidden
            end,
          })
        end,
        margin = 5,
      },
    })
  end,
}
