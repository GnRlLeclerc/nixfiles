# Graphics settings
{ config, lib, ... }:

with lib;

let
  cfg = config.settings;
in
{
  options.settings.graphics.enable = mkEnableOption "Enable graphics";

  config = mkIf cfg.graphics.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
