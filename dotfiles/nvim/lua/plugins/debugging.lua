return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  lazy = true,
  module = 'dap',
  keys = {
    { '<leader>dt', "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = 'Toggle breakpoint' },
    { '<leader>dc', "<cmd>lua require('dap').continue()<CR>", desc = 'Continue' },
  },
  config = function()
    local dap, dapui = require('dap'), require('dapui')

    require('dapui').setup()

    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.launch.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close
  end,
}
