# Shell configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.settings.shell;
in
{
  imports = [
    ./starship.nix
    ./packages.nix
    ./zsh.nix
  ];

  options.settings.shell.enable = mkEnableOption "Enable shell";
}
