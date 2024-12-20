# TOML language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.typst;
in
{
  options.settings.languages.typst.enable = mkEnableOption "Enable typst language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language
      typst

      # LSP
      tinymist

      # Formatter
      typstyle
    ];
  };
}
