# Tmux flavours configuration
# NOTE: see the tmux configuration for more details. Some flavours patches are directly applied there
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.tmux;
in
{
  options.programs.flavours.tmux = mkEnableOption "Enable tmux theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/tmux/themes/catppuccin_base16.tmuxtheme";
        template = "tmux";
        rewrite = true;
        hook = "tmux source ~/.config/tmux/tmux.conf";
      }
    ];
  };
}
