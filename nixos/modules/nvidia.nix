# Nvidia gpu settings
# See https://nixos.wiki/wiki/Nvidia to finish the setup for PRIME
{ config, lib, ... }:

with lib;

let
  cfg = config.settings;
in
{
  options.settings.nvidia.enable = mkEnableOption "Enable Nvidia gpu";

  config = mkIf cfg.nvidia.enable {
    # Enable graphics (see ./graphics.nix)
    settings.graphics.enable = true;

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      # TODO: Nvidia prime settings
      # prime = {
      #   offload = {
      #     enable = true;
      #     enableOffloadCmd = true;
      #   };
      # };

      modesetting.enable = true;

      # Nvidia power management (experimental)
      powerManagement.enable = false;

      # Fine-grained power management
      powerManagement.finegrained = false;

      # Do not use the open-source driver
      open = false;

      # Enable the Nvidia settings menu
      nvidiaSettings = true;

      # Nvidia driver
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
