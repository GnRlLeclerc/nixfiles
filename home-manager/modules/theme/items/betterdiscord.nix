# Betterdiscord flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.betterdiscord;
in
{
  options.programs.flavours.betterdiscord = mkEnableOption "Enable betterdiscord theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/BetterDiscord/themes/base16.theme.css";
        template = "betterdiscord";
        rewrite = true;
      }
    ];
  };
}
