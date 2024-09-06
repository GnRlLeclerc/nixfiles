# Neovim keymaps
{
  globals.mapleader = " ";

  keymaps = [
    # Move line down
    {
      mode = "n";
      key = "<A-j>";
      action = ":m .+1<CR>==";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "i";
      key = "<A-j>";
      action = "<Esc>:m .+1<CR>==gi";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = [ "v" ];
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Move line up
    {
      mode = "n";
      key = "<A-k>";
      action = ":m .-2<CR>==";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "i";
      key = "<A-k>";
      action = "<Esc>:m .-2<CR>==gi";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = [ "v" ];
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Navigate vim panes
    {
      mode = "n";
      key = "<C-k>";
      action = ":wincmd k<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = ":wincmd j<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-h>";
      action = ":wincmd h<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = ":wincmd l<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Navigate jump list
    {
      mode = "n";
      key = "<A-h>";
      action = "<C-o>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<A-l>";
      action = "<C-i>";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Buffer navigation
    {
      mode = "n";
      key = "<leader>bl";
      action = ":bnext<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bh";
      action = ":bprev<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = ":bdelete<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Select whole buffer
    {
      mode = "n";
      key = "<C-a>";
      action = "GVgg";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Close all buffers except the current one
    {
      mode = "n";
      key = "<leader>bo";
      action = "<cmd>%bd|e#<cr>";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Test notifications
    {
      mode = "n";
      key = "<leader>nt";
      action = ":lua require(\"notify\")(\"This is a notification!\")<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
  ];
}
