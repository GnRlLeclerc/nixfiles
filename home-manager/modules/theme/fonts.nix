# Fonts configuration
{ pkgs, ... }:
let
  gnome = {
    package = pkgs.cantarell-fonts;
    name = "Cantarell";
  };
in
{
  stylix.fonts = {
    serif = gnome;
    sansSerif = gnome;

    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };

    sizes = {
      terminal = 11;
    };
  };

  # Make these fonts available for apps not using the Stylix theme
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove

    # Kanji support
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}
