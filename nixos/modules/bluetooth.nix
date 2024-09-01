# Bluetooth settings
{ config, lib, ... }:

with lib;

let
  cfg = config.settings;
in
{
  options.settings.bluetooth.enable = mkEnableOption "Enable bluetooth";

  config = mkIf cfg.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}
