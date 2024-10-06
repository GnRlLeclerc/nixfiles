# Foliate theme configuration
{ config, lib, ... }:

with lib;

{
  config.xdg.configFile = mkIf config.stylix.targets.tmux.enable {
    "com.github.johnfactotum.Foliate/themes/base16.json".source = config.lib.stylix.colors {
      template = ./templates/foliate.mustache;
    };
  };
}
