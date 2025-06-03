# Theme configuration
{
  inputs,
  darwin,
  pkgs,
  ...
}:
{
  imports = [
    (if darwin then inputs.stylix.darwinModules.stylix else inputs.stylix.homeModules.stylix)

    ./extensions

    ./cursor.nix
    ./fonts.nix
    ./scheme.nix
    ./wallpaper.nix
  ];

  stylix = {
    opacity.terminal = 1.0;
    targets.firefox.profileNames = [ "default" ];
  };

  # Set papirus icons
  gtk.iconTheme = {
    name = "Papirus";
    package = pkgs.papirus-icon-theme;
  };
}
