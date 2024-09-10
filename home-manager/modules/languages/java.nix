# Java language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.java;
in
{
  options.settings.languages.java.enable = mkEnableOption "Enable java language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language (latest LTS JDK)
      jdk

      # LSP
      jdt-language-server

      # Formatter
      google-java-format
    ];
  };
}
