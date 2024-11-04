# All my nixos configurations, with home-manager as a module
{
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  nixos-hardware,
  overlays,
  inputs,
  ...
}:
let
  darwin = false;
  nixos = true;

  # Helper to create nixos configurations
  mkNixosConfiguration =
    config:
    let
      # Define secondary unstable packages
      unstable-pkgs = import nixpkgs-unstable {
        inherit (config) system;
        config = {
          allowUnfree = true;
        };
        overlays = overlays.unstable;
      };
    in
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          nixos
          darwin
          unstable-pkgs
          ;
        inherit (config) system;
      };
      modules = [
        { nixpkgs.overlays = overlays.stable; }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            users = config.users;
            extraSpecialArgs = {
              inherit
                inputs
                nixos
                darwin
                unstable-pkgs
                ;
              inherit (config) system;
            };
            backupFileExtension = "backup";
          };

        }
      ] ++ config.modules;
    };
in
{
  # Configuration for my main laptop
  main-laptop = mkNixosConfiguration {
    modules = [
      ./device-configuration/main-laptop.nix
      nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-nvidia
    ];
    users.thibaut = import ../home-manager/users/thibaut.nix;
    system = "x86_64-linux";
  };
}
