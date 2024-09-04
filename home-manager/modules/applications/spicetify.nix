# Spicetify configuration
{
  pkgs,
  spicetify-nix,
  ...
}:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    theme = spicePkgs.themes.sleek;
    colorScheme = "cherry"; # TODO: change and allow to customize using flavours

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };
}
