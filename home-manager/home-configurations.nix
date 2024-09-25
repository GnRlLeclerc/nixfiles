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
        darwin = config.system == "x86_64-darwin" || config.system == "aarch64-darwin";
        nixos = false; # Disable NixOS specific features (Chromium can only be themed from NixOS config, not home-manager)
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
