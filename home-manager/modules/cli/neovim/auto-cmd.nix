# Neovim autocmds
{
  autoCmd = [
    # Update conceal level in my Obsidian notes directory
    {
      event = "VimEnter";
      pattern = "*";
      callback = {
        __raw = ''
          function()
              if string.match(vim.fn.expand('%:p:h'), '/Notes$') then
                vim.opt.conceallevel = 1
              end
            end
        '';
      };
    }

    # Disable syntax highlighting when opening large files in a buffer (> 100KB)
    {
      event = "BufReadPost";
      pattern = "*";
      callback = {
        __raw = ''
          function()
              if vim.fn.getfsize(vim.fn.expand('%:p')) > 100 * 1024 then
                vim.cmd('syntax clear')
              end
            end
        '';
      };
    }
  ];
}
