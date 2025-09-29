# Power management config
{
  # Compress RAM
  zramSwap.enable = true;

  # Default NixOS power management
  powerManagement.enable = true;

  # Disable power profile daemons
  services.power-profiles-daemon.enable = false;

  # Prevent cpu overheating (intel-only)
  services.thermald.enable = true;

  # Throttling & battery life
  services.tlp = {
    enable = true;
    settings = {
      # CPU performance modes
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      # CPU performance scaling
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 40;

      # Battery life
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };
}
