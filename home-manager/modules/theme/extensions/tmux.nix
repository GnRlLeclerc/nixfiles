# Tmux catpuccin theme configuration
{ config, lib, ... }:

with lib;

{
  config.xdg.configFile = mkIf config.stylix.targets.tmux.enable {
    "tmux/themes/base16.tmuxtheme".source = config.lib.stylix.colors {
      template = ./templates/tmux-catppuccin.mustache;
    };
  };
}
