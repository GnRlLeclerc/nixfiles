{
  config,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    ./hardware/hardware-laptop.nix
    outputs.overlays

    ./modules/bluetooth.nix
    ./modules/bootloader.nix
    ./modules/desktop.nix
    ./modules/fonts.nix
    ./modules/garbage-collection.nix
    ./modules/graphics.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/power.nix
    ./modules/sound.nix
    ./modules/timezone.nix
    ./modules/users.nix
  ];

  # Setup the desktop environment and apps
  settings.desktop.enable = true;
  settings.desktop.environment = "gnome";

  settings.bluetooth.enable = true;
  settings.sound.enable = true;
  settings.graphics.enable = true;
  settings.me.enable = true;

  ##########################
  # Miscellaneous Settings #
  ##########################

  # Enable docker, but do not start it on boot (desktop context)
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  # Enable networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Auto mount drives
  services.udisks2.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # TTY keymaps
  console.keyMap = "fr";

  # Overriden by the flake (set to unstable)
  system.stateVersion = "24.05";
}
