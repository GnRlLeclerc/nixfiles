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
      slack
      obsidian
      signal-desktop
      # Broken: bitwarden-desktop

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

      # Game launcher (Minecraft)
      modrinth-app
      desmume # Nintendo DS emulator

      # Image edition
      gthumb
      gimp

      # EPUB viewer
      foliate

      zoom-us

      # XP Pen tabler driver
      libsForQt5.xp-pen-deco-01-v2-driver
    ];

  };
}
