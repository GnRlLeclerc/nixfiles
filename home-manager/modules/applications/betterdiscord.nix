# Betterdiscord configuration
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.discord;
in
{
  options.programs.discord.enable = mkEnableOption "Enable discord (betterdiscord)";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      betterdiscordctl
    ];
  };
}
