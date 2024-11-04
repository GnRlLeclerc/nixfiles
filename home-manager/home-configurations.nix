# All my standalone home-manager configurations
{
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  overlays,
  ...
}:
let
  # Helper function to generate a home-manager configuration
  mkHomeManagerConfiguration =
    config:
    let
      pkgs = import nixpkgs {
        inherit (config) system;
        config = {
          allowUnfree = true;
        };
        overlays = overlays.stable;
      };
      unstable-pkgs = import nixpkgs-unstable {
        inherit (config) system;
        config = {
          allowUnfree = true;
        };
        overlays = overlays.unstable;
      };
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs unstable-pkgs;
        inherit (config) system;
        darwin = config.system == "x86_64-darwin" || config.system == "aarch64-darwin";
        nixos = false; # Disable NixOS specific features (Chromium can only be themed from NixOS config, not home-manager)
        config.nix.settings.trusted-users = [ config.user.home.username ];
      };
      modules = [
        { nixpkgs.overlays = overlays.stable; }
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
