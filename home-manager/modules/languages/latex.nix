# Latex language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.latex;
in
{
  options.settings.languages.latex.enable = mkEnableOption "Enable latex language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language & tools
      texliveFull

      # LSP
      texlab
    ];
  };
}
