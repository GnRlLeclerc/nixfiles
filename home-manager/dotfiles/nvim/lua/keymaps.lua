-- Keymaps

-- Swap lines VSCode style

-- Move line down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move line down' })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true, desc = 'Move line down' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move lines down' })

-- Move line up
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true, desc = 'Move line up' })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true, desc = 'Move line up' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move lines up' })

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { noremap = true, silent = true, desc = 'Move to pane above' })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { noremap = true, silent = true, desc = 'Move to pane below' })
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { noremap = true, silent = true, desc = 'Move to pane left' })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { noremap = true, silent = true, desc = 'Move to pane right' })

-- Navigate to previous/next location in jump list like in VSCode
vim.keymap.set('n', '<A-h>', '<C-o>', { noremap = true, silent = true, desc = 'Navigate to previous location' })
vim.keymap.set('n', '<A-l>', '<C-i>', { noremap = true, silent = true, desc = 'Navigate to next location' })

-- Navigate between buffers
vim.keymap.set('n', '<leader>bl', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bh', ':bprev<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true, desc = 'Close buffer' })

-- Select the whole buffer
vim.keymap.set('n', '<C-a>', 'GVgg', { noremap = true, silent = true, desc = 'Select all' })

-- Prune buffers to avoid neovim slowdown
vim.keymap.set('n', '<leader>bo', '<cmd>%bd|e#<cr>', { desc = 'Close all buffers but the current one' })

--  Test notifications
vim.keymap.set(
  'n',
  '<leader>nt',
  ':lua require("notify")("This is a notification!")<CR>',
  { noremap = true, silent = true, desc = 'Test info notification' }
)
