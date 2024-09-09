# CMake language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.cmake;
in
{
  options.settings.languages.cmake.enable = mkEnableOption "Enable cmake language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language
      cmake

      # LSP
      cmake-language-server

      # Formatter
      cmake-format
    ];
  };
}
