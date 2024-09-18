# Kitty flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.kitty;
in
{
  options.programs.flavours.kitty = mkEnableOption "Enable kitty theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/kitty/current-theme.conf";
        template = "kitty";
        rewrite = true;
        hook = "kitty @ set-colors --all ${config.xdg.configHome}/kitty/current-theme.conf";
      }
    ];

    # Load the base16 theme
    kitty.extraConfig = ''
      # Load the base16 theme
      include current-theme.conf
    '';
  };
}
