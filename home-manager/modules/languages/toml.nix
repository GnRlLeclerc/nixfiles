# TOML language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.toml;
in
{
  options.settings.languages.toml.enable = mkEnableOption "Enable toml language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # LSP & formatter
      taplo
    ];
  };
}
