# Sound settings
{ config, lib, ... }:

with lib;

let
  cfg = config.settings;
in
{
  options.settings.sound.enable = mkEnableOption "Enable sound";

  config = mkIf cfg.sound.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # Switch between the Speaker and Headphones profiles on headphone jack changes
      wireplumber.extraScripts."device/find-jack-profile.lua" =
        builtins.readFile ./wireplumber/jack-profile.lua;
      wireplumber.extraConfig."50-jack-profile" = {
        "wireplumber.components" = [
          {
            name = "device/find-jack-profile.lua";
            type = "script/lua";
            provides = "custom.device.jack-profile";
          }
        ];
        "wireplumber.profiles".main."custom.device.jack-profile" = "required";
      };

      # Single volume layer: streams always follow the default sink and start at 100%,
      # so only the (per-device) sink volume matters. Moving a stream is not remembered.
      wireplumber.extraConfig."51-stream-state" = {
        "wireplumber.settings" = {
          "node.stream.restore-target" = false;
          "node.stream.restore-props" = false;
        };
      };
    };
  };
}
