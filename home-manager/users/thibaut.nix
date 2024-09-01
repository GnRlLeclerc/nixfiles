{ config, pkgs, ... }:

{
  imports = [
    ../base-home.nix
  ];

  ##########################
  # Miscellaneous settings #
  ##########################

  # User management
  home = {
    username = "thibaut";
    homeDirectory = "/home/thibaut";

    packages = with pkgs; [
    ];
  };
}
