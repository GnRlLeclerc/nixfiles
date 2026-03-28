# Configuration for my work laptop at telecom
{ pkgs, ... }:
{
  imports = [
    ../base-configuration.nix
    ../hardware-configuration/telecom-laptop.nix
  ];

  # Latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Setup the desktop environment and apps
  settings.desktop.enable = true;

  settings.bluetooth.enable = true;
  settings.sound.enable = true;
  settings.graphics.enable = true;
  settings.me.enable = true;

  hardware.nvidia.open = false;

  services.fwupd.enable = true;

  # Enable Vulkan rendering
  # Prefer rendering with the AMD GPU
  # environment.sessionVariables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  # Prefer renderin with the Nvidia GPU
  # environment.sessionVariables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";

  ##########################
  # Miscellaneous Settings #
  ##########################

  # Enable docker, but do not start it on boot (desktop context)
  virtualisation.docker.enableOnBoot = false;

  networking.hostName = "nixos";

  system.stateVersion = "25.11";
}
