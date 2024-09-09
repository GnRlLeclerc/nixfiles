# Lua language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.lua;
in
{
  options.settings.languages.lua.enable = mkEnableOption "Enable lua language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language
      lua5_4_compat

      # LSP
      lua-language-server

      # Formatter
      stylua
    ];
  };
}
