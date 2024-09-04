{ ... }:

{

  # Modules
  imports = [
    ./modules/applications
    ./modules/fonts.nix
    ./modules/git.nix
  ];

  ##########################
  # Miscellaneous settings #
  ##########################

  services.flatpak.enableModule = true;
  services.flatpak.packages = [ ];
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
