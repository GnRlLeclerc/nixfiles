# Rust language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.rust;
in
{
  options.settings.languages.rust.enable = mkEnableOption "Enable rust language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language
      # Using Oxalica rust overlay
      rust-bin.stable.latest.default

      # Language server
      rust-analyzer
    ];
  };
}
