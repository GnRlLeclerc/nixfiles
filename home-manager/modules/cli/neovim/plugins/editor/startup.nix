# startup.nvim
{
  plugins.startup = {
    enable = true;

    sections = {
      # Section 1: ASCII Art Header
      header = {
        type = "text";
        oldfilesDirectory = false;
        align = "center";
        foldSection = false;
        title = "Startup Screen";
        margin = 5;
        content = [
          "    ◯                                                               "
          "    ╰────███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗─◯ ╭───◯ "
          " ◯─╮  ◯──████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║───╯     "
          "   ╰─────██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║───◯     "
          "   ◯─────██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║──◯      "
          "    ╭────██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║─────╮   "
          "    │    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝     ◯   "
          "◯───╯    ◯───┬───┬─┬─┬────┬─┬─┬─┬─────┬─────┬─┬────┬────┬─◯         "
          "            ◯╯   ◯ │ ◯   ◯┤ │ ◯ │     ╰◯    │ │    ├◯   ◯           "
          "                   ◯      │ ◯   ├◯         ◯┤ ◯    ◯                "
          "                         ◯┤     ◯           ◯                       "
          "                          ◯                                         "
        ];
        highlight = "Keyword"; # Highlight group for the ASCII text
        defaultColor = "";
        oldfilesAmount = 0;
      };

      # Section 2: Menu Buttons
      body = {
        type = "mapping";
        oldfilesDirectory = false;
        align = "center";
        foldSection = false;
        title = "Menu";
        margin = 5;
        content = [
          [
            "  Find File"
            "<cmd>Telescope find_files<CR>"
            "LDR fd"
          ]
          [
            "  Find Word"
            "<cmd>Telescope live_grep<CR>"
            "LDR fg"
          ]
          [
            "  File Tree"
            "<cmd>NvimTreeToggle<CR>"
            "LDR b"
          ]
          [
            "󰂖  Plugins"
            "<cmd>Lazy<CR>"
            "p"
          ]
          [
            "󰅚  Quit"
            ":qa<CR>"
            "q"
          ]
        ];
        highlight = "Function"; # Highlight group for the menu options
        defaultColor = "";
        oldfilesAmount = 0;
      };
    };

    options = {
      paddings = [
        3
        2
        2
      ]; # Paddings for the sections
    };

    parts = [
      "header" # Include the ASCII art header
      "body" # Include the menu options
    ];
  };
}
