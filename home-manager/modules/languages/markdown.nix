# Markdown language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.markdown;
in
{
  options.settings.languages.markdown.enable = mkEnableOption "Enable markdown language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # LSP
      marksman

      # Formatter
      prettierd
    ];
  };
}
