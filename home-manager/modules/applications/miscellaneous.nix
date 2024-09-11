# Useful desktop applications (that do not need individual configuration)
{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  config = mkIf config.settings.desktop-applications.enable {
    home.packages = with pkgs; [
      kitty
      slack
      obsidian
      signal-desktop
      bitwarden-desktop

      # Libre Office fresh + spellcheck
      libreoffice-fresh
      hunspell
      hunspellDicts.fr-any
      hunspellDicts.en-us
      hunspellDicts.en-gb-ise

      # Backlight control
      brightnessctl

      # Sound control
      playerctl

      # Wayland clipboard utilities
      wl-clipboard
    ];

  };
}
