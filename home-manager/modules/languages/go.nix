# Go language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.go;
in
{
  options.settings.languages.go.enable = mkEnableOption "Enable go language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language
      go_1_24

      # Language server
      gopls

      # Formatter
      gotools
    ];
  };
}
