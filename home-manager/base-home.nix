{ inputs, ... }:
{

  # Modules
  imports = [
    ./modules/applications
    ./modules/cli
    ./modules/languages
    ./modules/appearance.nix
    ./modules/cache.nix
    ./modules/git.nix
  ];

  ##########################
  #      Nix settings      #
  ##########################

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Pin the nixpkgs registry to the flake input
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
