# Sound settings
{ config, lib, ... }:

with lib;

let
  cfg = config.settings;
in {
  options.settings.sound.enable = mkEnableOption "Enable sound";

  config = mkIf cfg.sound.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
