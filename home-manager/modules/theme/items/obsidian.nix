# Obsidian flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.obsidian;
in
{
  options.programs.flavours.obsidian = mkEnableOption "Enable obsidian theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.home.homeDirectory}/Notes/.obsidian/snippets/base16.css";
        template = "obsidian";
        rewrite = true;
      }
    ];
  };
}
