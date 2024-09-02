{ config, pkgs, ... }:

{

  # Modules
  imports = [
    ./modules/git.nix
  ];

  ##########################
  # Miscellaneous settings #
  ##########################

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
