# Configuration for my main personal laptop
{ pkgs, ... }:
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

  # Enable Vulkan rendering
  # Prefer rendering with the AMD GPU
  environment.sessionVariables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  # Prefer renderin with the Nvidia GPU
  # environment.sessionVariables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";

  ##########################
  # Miscellaneous Settings #
  ##########################

  # Enable docker, but do not start it on boot (desktop context)
  virtualisation.docker.enableOnBoot = false;

  networking.hostName = "nixos";

  # Fix suspend/resume cycling because of nvidia power management
  # https://discourse.nixos.org/t/suspend-resume-cycling-on-system-resume/32322/12
  systemd = {
    services."gnome-suspend" = {
      description = "suspend gnome shell";
      before = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
        "nvidia-suspend.service"
        "nvidia-hibernate.service"
      ];
      wantedBy = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''${pkgs.procps}/bin/pkill -f -STOP ${pkgs.gnome-shell}/bin/gnome-shell'';
      };
    };
    services."gnome-resume" = {
      description = "resume gnome shell";
      after = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
        "nvidia-resume.service"
      ];
      wantedBy = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''${pkgs.procps}/bin/pkill -f -CONT ${pkgs.gnome-shell}/bin/gnome-shell'';
      };
    };
  };
}
