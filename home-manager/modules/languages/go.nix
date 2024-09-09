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
      go

      # Language server
      gopls

      # Formatter
      gotools
    ];
  };
}
