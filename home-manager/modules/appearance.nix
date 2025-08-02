# Cursor, fonts, etc.
{ pkgs, ... }:
{
  # TODO: separate GTK from Hyprland

  # Cursor
  gtk.cursorTheme = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;
  };
  # Set papirus icons
  gtk.iconTheme = {
    name = "Papirus";
    package = pkgs.papirus-icon-theme;
  };

  # Fonts
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove

    # Kanji support
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  fonts.fontconfig.enable = true;
}
