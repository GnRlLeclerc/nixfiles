# Python language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.python;
in
{
  options.settings.languages.python.enable = mkEnableOption "Enable python language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language (latest python version)
      python3

      # Useful build tools
      hatch

      # LSP
      pyright

      # Formatter
      isort
      black
    ];
  };
}
