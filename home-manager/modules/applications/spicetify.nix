# Spicetify configuration
{
  pkgs,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  config.programs.spicetify = {
    theme = spicePkgs.themes.sleek;
    colorScheme = "cherry"; # TODO: change and allow to customize using flavours

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };
}
