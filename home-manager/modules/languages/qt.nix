# Qt and QML language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.qt;
in
{
  options.settings.languages.qt.enable = mkEnableOption "Enable Qt and QML language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # All tools
      kdePackages.qtdeclarative
    ];
  };
}
