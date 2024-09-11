{ inputs, ... }:

{

  # Modules
  imports = [
    ./modules/applications
    ./modules/cli
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/languages
  ];

  ##########################
  # Miscellaneous settings #
  ##########################

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Pin the nixpkgs registry to the flake input
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
