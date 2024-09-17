# Configuration for my main personal laptop
{
  imports = [
    ../base-configuration.nix
    ../hardware-configuration/main-laptop.nix
  ];

  # TODO : check if this one is needed (seems to map to part 1 ?)
  # boot.initrd.luks.devices."luks-7dc9552a-021b-46a1-8b92-ebdd96e3ef13".device = "/dev/disk/by-uuid/7dc9552a-021b-46a1-8b92-ebdd96e3ef13";

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
