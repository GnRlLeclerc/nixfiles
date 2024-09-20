# VSCode flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.vscode;
in
{
  options.programs.flavours.vscode = mkEnableOption "Enable vscode theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/Code/User/theme.json";
        template = "vscode";
        subtemplate = "base16";
        rewrite = true;
      }
    ];
  };
}
