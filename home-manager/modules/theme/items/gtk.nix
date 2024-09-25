# GTK flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.gtk;
in
{
  options.programs.flavours.gtk = mkEnableOption "Enable gtk theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/gtk-3.0/gtk.css";
        template = "gtk";
        rewrite = true;
      }
      {
        file = "${config.xdg.configHome}/gtk-4.0/gtk.css";
        template = "gtk";
        rewrite = true;
      }
    ];
  };
}
