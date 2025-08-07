# Make language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.make;
in
{
  options.settings.languages.make.enable = mkEnableOption "Enable make language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language
      gnumake

      # LSP
      # python3.13-lsp-tree-sitter package broken
      # autotools-language-server
    ];
  };
}
