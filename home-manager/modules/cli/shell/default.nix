# Shell configuration
{ lib, ... }:

with lib;

{
  imports = [
    ./starship.nix
    ./packages.nix
    ./zsh.nix
  ];

  options.settings.shell.enable = mkEnableOption "Enable shell";
}
