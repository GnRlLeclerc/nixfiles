# Desktop application module
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.desktop-apps;
in {
  options.programs.desktop-apps.enable = mkEnableOption "Usual desktop apps";
  config = mkIf cfg.enable {
    programs.firefox.enable = true;   

    # Other desktop applications
    environment.systemPackages = with pkgs; [
      kitty
      slack
      obsidian
    ];
  };
}
