# All my standalone home-manager configurations
{
  inputs,
  nixpkgs,
  nixpkgs-stable,
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
        overlays = overlays.unstable;
      };
      stable-pkgs = import nixpkgs-stable {
        inherit (config) system;
        config = {
          allowUnfree = true;
        };
        overlays = overlays.stable;
      };
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs stable-pkgs;
        inherit (config) system;
        darwin = config.system == "x86_64-darwin" || config.system == "aarch64-darwin";
        nixos = false; # Disable NixOS specific features (Chromium can only be themed from NixOS config, not home-manager)
        config.nix.settings.trusted-users = [ config.user.home.username ];
      };
      modules = [
        { nixpkgs.overlays = overlays.unstable; }
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
