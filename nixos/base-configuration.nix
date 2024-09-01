{
  config,
  lib,
  pkgs,
  outputs,
  ...
}:

with lib;

{
  imports = [
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

  ##########################
  # Miscellaneous Settings #
  ##########################

  # Enable docker
  virtualisation.docker.enable = mkDefault true;

  # Enable networking
  networking.networkmanager.enable = mkDefault true;

  # Auto mount drives
  services.udisks2.enable = mkDefault true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = mkDefault true;

  # Enable flatpak
  services.flatpak.enable = mkDefault true;

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # TTY keymaps
  console.keyMap = mkDefault "fr";

  # Overriden by the flake (set to unstable)
  system.stateVersion = "24.05";
}
