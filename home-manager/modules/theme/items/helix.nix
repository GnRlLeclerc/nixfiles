# Helix flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.helix;
in
{
  options.programs.flavours.helix = mkEnableOption "Enable helix theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/helix/themes/base16.toml";
        template = "helix";
        rewrite = true;
      }
    ];
    helix.settings.theme = "base16";
  };
}
