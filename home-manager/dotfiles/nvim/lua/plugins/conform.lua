-- Formatting settings
-- This is especially needed given how hard it is to cherry pick formatting providers
-- using the default api (tsserver vs prettier)
return {
  'stevearc/conform.nvim',
  -- Lazy load conform
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'FormatToggle' },
  config = function()
    local conform = require('conform')
    conform.setup({
      formatters_by_ft = {
        bash = { 'shfmt' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        cmake = { 'cmake_format' },
        css = { 'prettier' },
        go = { 'goimports' },
        html = { 'prettier' },
        java = { 'google-java-format' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        json = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        nix = { 'nixfmt' },
        python = { 'isort', 'black' },
        rust = { 'rustfmt' },
        scss = { 'prettier' },
        sh = { 'shfmt' },
        tex = { 'latexindent' },
        toml = { 'taplo' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        yaml = { 'prettier' },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          ---@diagnostic disable-next-line: missing-return-value
          return
        end
        return { timeout_ms = 2500, lsp_fallback = true }
      end,
    })

    -- Default formatter arguments
    conform.formatters.stylua = {
      prepend_args = {
        '--indent-type',
        'Spaces',
        '--indent-width',
        '2',
        '--line-endings',
        'Unix',
        '--quote-style',
        'AutoPreferSingle',
      },
    }

    local notify = require('notify')
    local function show_notification(message, level)
      notify(message, level, { title = 'conform.nvim' })
    end

    -- Add a command to toggle formatting on save on or off
    vim.api.nvim_create_user_command('FormatToggle', function(args)
      local is_global = not args.bang
      if is_global then
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        if vim.g.disable_autoformat then
          show_notification('Autoformat-on-save disabled globally', 'info')
        else
          show_notification('Autoformat-on-save enabled globally', 'info')
        end
      else
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        if vim.b.disable_autoformat then
          show_notification('Autoformat-on-save disabled for this buffer', 'info')
        else
          show_notification('Autoformat-on-save enabled for this buffer', 'info')
        end
      end
    end, {
      desc = 'Toggle autoformat-on-save',
      bang = true,
    })
  end,
}
