# Kitty Configuration
# WARNING: open kitty with `kitty -1` to share the instance
{
  programs.kitty = {
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10.5;
    };

    shellIntegration.mode = "no-cursor";

    settings = {
      # General behavior
      scrollback_lines = 5000;

      # Background
      background_opacity = 1;
      hide_window_decorations = "yes";

      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = "0.8";

      # Allow remote control for dynamic theme change
      allow_remote_control = "yes";

      # Window padding
      window_padding_width = 4;

      # Tab bar
      tab_bar_style = "powerline";
    };
  };
}
