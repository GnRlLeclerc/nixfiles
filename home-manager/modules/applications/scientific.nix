# Scientific packages configuration
{
  lib,
  # pkgs,
  config,
  ...
}:

with lib;

let
  cfg = config.programs.scientific;
in
{
  options.programs.scientific.enable = mkEnableOption "Scientific desktop applications";

  config = mkIf cfg.enable {
    home.packages = [ ];
  };
}
