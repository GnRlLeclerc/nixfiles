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

    # Home-manager cache settings (used for non nixos systems)
    ../nixos/modules/cache.nix
  ];

  ##########################
  #      Nix settings      #
  ##########################

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = mkDefault true;

  # Pin the nixpkgs registry to the flake input
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
