# Theme configuration
{
  inputs,
  darwin,
  ...
}:
{
  imports = [
    (if darwin then inputs.stylix.darwinModules.stylix else inputs.stylix.homeManagerModules.stylix)

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

}
