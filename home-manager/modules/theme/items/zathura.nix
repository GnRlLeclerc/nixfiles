# Zathura flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.zathura;
in
{
  options.programs.flavours.zathura = mkEnableOption "Enable zathura theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/zathura/colors.conf";
        template = "zathura";
        subtemplate = "recolor-patch";
        rewrite = true;
      }
    ];
    zathura.extraConfig = ''
      include colors.conf
    '';
  };
}
