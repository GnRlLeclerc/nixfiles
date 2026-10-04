# Configuration for my main personal laptop
_: {
  imports = [
    ../base-configuration.nix
    ../hardware-configuration/main-laptop.nix
  ];

  # Setup the desktop environment and apps
  settings.desktop.enable = true;

  settings.bluetooth.enable = true;
  settings.sound.enable = true;
  settings.graphics.enable = true;
  settings.me.enable = true;

  hardware.nvidia.open = false;

  # Run the NVIDIA driver without the GSP firmware: with it, the dGPU stops answering
  # (Xid 119) when an ACPI event wakes it from runtime D3, then suspend & shutdown hang
  hardware.nvidia.moduleParams.nvidia.NVreg_EnableGpuFirmware = 0;

  services.fwupd.enable = true;

  # Battery life (Lenovo IdeaPad/Yoga): STOP=1 enables conservation mode (~60%), START is ignored
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 70;
    STOP_CHARGE_THRESH_BAT0 = 1;
  };

  # Enable Vulkan rendering
  # Prefer rendering with the AMD GPU
  # environment.sessionVariables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  # Prefer rendering with the Nvidia GPU
  # environment.sessionVariables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";

  ##########################
  # Miscellaneous Settings #
  ##########################

  # Enable docker, but do not start it on boot (desktop context)
  virtualisation.docker.enableOnBoot = false;

  networking.hostName = "nixos";

  system.stateVersion = "24.05";
}
