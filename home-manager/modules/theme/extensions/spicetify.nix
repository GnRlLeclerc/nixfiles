# Spicetify theme configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.stylix.targets.spicetify;
  colors = config.lib.stylix.colors;
in
{
  options.stylix.targets.spicetify.enable = config.lib.stylix.mkEnableTarget "Spicetify" true;

  config.programs.spicetify = mkIf (cfg.enable && config.programs.spicetify.enable) {
    colorScheme = "custom";
    customColorScheme = with colors; {
      text = base05;
      subtext = base06;
      nav-active-text = base04;
      sidebar-text = base05;
      main = base00;
      sidebar = base00;
      player = base00;
      card = base00;
      shadow = base00;
      main-secondary = base02;
      selected-row = base01;
      button = base0D;
      button-secondary = base04;
      button-active = base0C;
      button-disabled = base02;
      nav-active = base03;
      play-button = base0D;
      tab-active = base01;
      notification = base01;
      notification-error = base01;
      playback-bar = base06;
      misc = "FFFFFF";
    };
  };
}
