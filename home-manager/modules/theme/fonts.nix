# Fonts configuration
{ pkgs, ... }:
let

  nerdfonts = (
    pkgs.nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "CascadiaCode"
      ];
    }
  );

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
      package = nerdfonts;
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
  home.packages = [
    nerdfonts
  ];
}
