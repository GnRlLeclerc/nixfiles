# Useful default settings for helix
{
  programs.helix.settings = {
    editor = {
      line-number = "relative";
      lsp.display-messages = true;
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "block";
      };
      file-picker = {
        hidden = false;
        git-ignore = false;
      };
      whitespace.characters = {
        space = "·";
        nbsp = "⍽";
        tab = "→";
        newline = "⏎";
        tabpad = "·";
      };
      statusline = {
        left = [
          "mode"
          "spacer"
          "version-control"
          "spacer"
          "separator"
          "file-name"
          "file-modification-indicator"
        ];
        right = [
          "spinner"
          "spacer"
          "workspace-diagnostics"
          "separator"
          "spacer"
          "diagnostics"
          "position"
          "file-encoding"
          "file-line-ending"
          "file-type"
        ];
        separator = "╎";
        mode.normal = "NORMAL";
        mode.insert = "INSERT";
        mode.select = "SELECT";
      };
      indent-guides.render = true;
    };
    keys = {
      normal = {
        "A-k" = [
          "extend_to_line_bounds"
          "delete_selection"
          "move_line_up"
          "paste_before"
        ];
        "A-j" = [
          "extend_to_line_bounds"
          "delete_selection"
          "move_line_down"
          "paste_before"
        ];
      };
      insert = {
        "C-space" = "completion";
      };
    };
  };
}
