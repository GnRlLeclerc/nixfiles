{ ... }:

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
}
