# Tmux flavours configuration
# BUG: the theme is not applied...
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
        file = "${config.xdg.configHome}/tmux/plugins/tmux/themes/catppuccin_base16.tmuxtheme";
        template = "tmux";
        rewrite = true;
        hook = "tmux source ~/.config/tmux/tmux.conf";
      }
    ];

    tmux.extraConfig = ''
      set -g @catppuccin_flavour 'base16'  # Custom theme
    '';
  };
}
