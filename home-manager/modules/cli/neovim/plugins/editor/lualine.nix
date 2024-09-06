# Lualine configuration
{
  plugins.lualine = {
    enable = true;

    # Adding Copilot as a dependency
    dependencies = [
      "nvim-tree/nvim-web-devicons"
      "AndreM222/copilot-lualine"
    ];

    # Event that triggers lualine
    event = "BufRead";

    extensions = [
      "neo-tree"
    ];

    theme = "dynamic-base16"; # Dynamic theme

    sections = {
      # Left section of lualine (a and b)
      lualine_a = [
        {
          name = "mode"; # Displays the current mode
        }
      ];

      lualine_b = [
        {
          name = "filetype"; # Displays the file type
          extraConfig = {
            icon_only = true;
            separator = "";
            padding = {
              left = 1;
              right = 0;
            };
          };
        }
        {
          name = "filename"; # Displays the file name with an icon
          extraConfig = {
            icon = "󰑃";
          };
        }
      ];

      # Central section (branch and diff)
      lualine_c = [
        {
          name = "branch"; # Git branch info
        }
        {
          name = "diff"; # Git diff status
        }
      ];

      # Right section of lualine (x, y, and z)
      lualine_x = [ ];

      lualine_y = [
        {
          name = "diagnostics"; # Diagnostic info (error, warn, info)
        }
        {
          name = "copilot"; # Copilot status
        }
        {
          name = "encoding"; # File encoding (e.g., UTF-8)
        }
        {
          name = "fileformat"; # File format (e.g., Unix, DOS)
        }
      ];

      lualine_z = [
        {
          name = "progress"; # File progress with an icon
          extraConfig = {
            icon = "";
          };
        }
        {
          name = "location"; # Line and column location
        }
      ];
    };

    options = {
      sectionSeparators = {
        left = "";
        right = "";
      };
      # Ignore certain filetypes (optional, add back if needed)
      # ignoreFocus = ["neo-tree"];
    };
  };
}
