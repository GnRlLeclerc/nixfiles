{ inputs, lib, ... }:

with lib;

{

  # Modules
  imports = [
    ./modules/applications
    ./modules/cli
    ./modules/git.nix
    ./modules/languages
    ./modules/theme
    ./modules/cache.nix
  ];

  ##########################
  #      Nix settings      #
  ##########################

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Pin the nixpkgs registry to the flake input
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
