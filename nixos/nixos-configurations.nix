# All my nixos configurations, with home-manager as a module
{
  nixpkgs,
  home-manager,
  nixos-hardware,
  overlays,
  inputs,
  ...
}:
let
  # Helper to create nixos configurations
  mkNixosConfiguration =
    config:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit (config) system;
      };
      modules = [
        overlays

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users = config.users;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            inherit (config) system;
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
