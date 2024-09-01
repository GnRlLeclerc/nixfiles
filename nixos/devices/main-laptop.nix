# Configuration for my main personal laptop
{
  config,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    ../base-configuration.nix
    ../hardware-configuration/main-laptop.nix
  ];

  # Setup the desktop environment and apps
  settings.desktop.enable = true;
  settings.desktop.environment = "gnome";

  settings.bluetooth.enable = true;
  settings.sound.enable = true;
  settings.graphics.enable = true;
  settings.me.enable = true;

  hardware.nvidia.open = false;

  ##########################
  # Miscellaneous Settings #
  ##########################

  # Enable docker, but do not start it on boot (desktop context)
  virtualisation.docker.enableOnBoot = false;

  networking.hostName = "nixos";
}
