# All my standalone home-manager configurations
{
  inputs,
  nixpkgs,
  home-manager,
  overlays,
  ...
}:
let
  # Helper function to generate a home-manager configuration
  mkHomeManagerConfiguration =
    config:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${config.system};
      extraSpecialArgs = {
        inherit inputs;
        inherit (config) system;
      };
      modules = [
        overlays
        config.user
      ];
    };
in
{
  # My own user
  thibaut = mkHomeManagerConfiguration {
    system = "x86_64-linux";
    user = ./users/thibaut.nix;
  };
}
