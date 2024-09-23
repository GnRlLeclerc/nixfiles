# Spicetify configuration
{
  pkgs,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  config = {
    programs.spicetify = {
      theme = spicePkgs.themes.sleek;
      colorScheme = "cherry"; # TODO: change and allow to customize using flavours

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
      ];
    };
  };
}
