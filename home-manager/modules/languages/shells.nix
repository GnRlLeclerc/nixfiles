# Bash, Fish and nushell language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.shells;
in
{
  options.settings.languages.shells.enable = mkEnableOption "Enable shells language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language
      bash
      fish
      nushell

      # LSP
      bash-language-server
      fish-lsp

      # Formatter
      shfmt
      # fish_indent available in fish shell
    ];
  };
}
