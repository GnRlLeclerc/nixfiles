# Bash, ZSH and nushell language support
{
  config,
  lib,
  pkgs,
  unstable-pkgs,
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
      zsh
      nushell

      # LSP
      unstable-pkgs.bash-language-server

      # Formatter
      shfmt
    ];
  };
}
