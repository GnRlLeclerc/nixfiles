# Useful desktop applications (that do not need individual configuration)
{ pkgs, lib, ... }:

with lib;

{
  config = mkIf config.settings.desktop-applications {
    home.packages = with pkgs; [
      kitty
      slack
      obsidian
      vscode-fhs
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
