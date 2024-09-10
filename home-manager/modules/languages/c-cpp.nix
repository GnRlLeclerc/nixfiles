# C and C++ language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.c-cpp;
in
{
  options.settings.languages.c-cpp.enable = mkEnableOption "Enable C and C++ language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Build tools
      cmake
      gnumake

      # Debuggers
      gdb
      valgrind

      # LSP & formatters
      clang-tools

      # Compilers
      gcc
      clang
    ];
  };
}
