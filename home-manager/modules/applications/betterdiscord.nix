# Betterdiscord configuration
# Run `betterdiscordctl install` to install betterdiscord
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
