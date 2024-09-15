# Kitty Configuration
{
  programs.kitty = {
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10.5;
    };

    settings = {
      # General behavior
      scrollback_lines = 5000;

      # Background
      background_opacity = 1;
      hide_window_decorations = "yes";

      # Cursor
      shell_integration = "no-cursor";
      cursor_blink_interval = "0.8";

      # Allow remote control for dynamic theme change
      allow_remote_control = "yes";

      # Window padding
      window_padding_width = 4;

      # Tab bar
      tab_bar_style = "powerline";
    };

    theme = "Tokyo Night Moon";
  };
}
