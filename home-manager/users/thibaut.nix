{ config, pkgs, ... }:

{
  imports = [
    ../base-home.nix
    ../modules/git.nix
  ];

  ##########################
  # Miscellaneous settings #
  ##########################

  # User management
  home = {
    username = "thibaut";
    homeDirectory = "/home/thibaut";

    packages =
      with pkgs;
      [
      ];
  };

  programs.git = {
    enable = true;
    userEmail = "thibaut2saivre@gmail.com";
    userName = "Thibaut";
  };
}
