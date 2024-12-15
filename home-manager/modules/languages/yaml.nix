# YAML language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.yaml;
in
{
  options.settings.languages.yaml.enable = mkEnableOption "Enable yaml language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # LSP
      yaml-language-server

      # Formatter
      nodePackages.prettier
    ];
  };
}
