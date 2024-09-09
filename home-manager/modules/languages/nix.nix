# Nix language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.nix;
in
{
  options.settings.languages.nix.enable = mkEnableOption "Enable nix language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # LSP
      nil

      # Formatter
      nixfmt-rfc-style
    ];
  };
}
