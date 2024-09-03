# Useful desktop applications
{ pkgs, ... }:
{
  # Desktop programs
  programs.firefox.enable = true;

  # TODO : add all other apps (chromium) + use the home manager options when possible
  home.packages = with pkgs; [
    kitty
    slack
    obsidian
    vscode-fhs

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

}
