# The base nixos configuration for any of my devices
{
  inputs,
  lib,
  ...
}:

with lib;

{
  imports = [
    ./modules/bluetooth.nix
    ./modules/bootloader.nix
    ./modules/desktop.nix
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
  nixpkgs.config.cudaSupport = mkDefault true;

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

  # Pin the nixpkgs registry to the flake input
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
