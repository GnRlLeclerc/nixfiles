# Shaders language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.shaders;
in
{
  options.settings.languages.shaders.enable = mkEnableOption "Enable shaders language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language server
      wgsl-analyzer
    ];
  };
}
