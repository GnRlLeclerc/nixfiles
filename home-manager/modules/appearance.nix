# Cursor, fonts, etc.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    maple-mono.NF-unhinted
    inter

    # Kanji support
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    # Icon theme
    papirus-icon-theme

    # Cursor theme
    rose-pine-cursor
  ];

  fonts.fontconfig.enable = true;
}
