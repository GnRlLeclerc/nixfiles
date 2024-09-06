# Neoons
{
  config = {

    extraConfigLuaPre = ''
      -- Set language to English
      vim.cmd('language en_US')
    '';

    extraConfigLuaPost = ''
      -- Set LSP diagnostic icons
      local symbols = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }

      for name, icon in pairs(symbols) do
        local hl = 'DiagnosticSign' .. name
        vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
      end

      -- Open a diagnostic window to show the full diagnostic
      -- Can also be inspected using trouble.nvim
      local showDiagnostic = function()
        local opts = {
          focusable = false,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          border = 'rounded',
          source = 'always', -- This shows the source of the diagnostic
          prefix = ' ',
          scope = 'cursor', -- Shows diagnostics for the current cursor position
        }
        vim.diagnostic.open_float(nil, opts)
      end

      -- Set the keymap to call the global function
      vim.keymap.set('n', '<leader>dd', showDiagnostic, { noremap = true, silent = true, desc = 'Show diagnostics' })
    '';

    opts = {
      # Start scrolling 5 lines before hitting the edge of the screen with the cursor
      scrolloff = 5;

      # Use sytem clipboard
      clipboard = "unnamedplus";

      # Default indentation settings
      # Set tab width to 2 spaces
      tabstop = 2;
      # Set tab movement size
      softtabstop = 2;
      # Set shift width to 2 spaces
      shiftwidth = 2;
      # Set expandtab to convert tabs to spaces
      expandtab = true;

      # Enable relative line numbers
      number = true;
      relativenumber = true;

      # Folding options
      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      # TODO:
      # fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff:╱]] # Clean fold style and nice diff style

      # Use 24 bit colors for nvim-notify fade in-out
      termguicolors = true;
      pumheight = 10; # Limit max completions height
    };
  };
}
