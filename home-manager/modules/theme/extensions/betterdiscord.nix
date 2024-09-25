# Betterdiscord theme configuration
{ config, lib, ... }:
with lib;

let
  cfg = config.stylix.targets.betterdiscord;
in
{
  options.stylix.targets.betterdiscord.enable = config.lib.stylix.mkEnableTarget "BetterDiscord" true;

  config = mkIf cfg.enable {
    xdg.configFile."BetterDiscord/themes/base16.theme.css".source = config.lib.stylix.colors {
      template = ./templates/betterdiscord.mustache;
    };

    xdg.configFile."BetterDiscord/data/stable/themes.json".text = builtins.toJSON {
      dynamic-base16 = true;
    };
  };
}
