{ config, pkgs, outputs, ... }:
{
  imports = [
    ./hardware/hardware-laptop.nix
    outputs.overlays

    ./modules/bootloader.nix
    ./modules/desktop.nix
    ./modules/graphics.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/sound.nix
    ./modules/timezone.nix
    ./modules/users.nix
  ];

  # Setup the desktop environment and apps
  settings.desktop.enable = true;
  settings.desktop.environment = "gnome";

  settings.sound.enable = true;
  settings.graphics.enable = true;
  settings.me.enable = true;

  ##########################
  # Miscellaneous Settings #
  ##########################

  # Enable networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # TTY keymaps
  console.keyMap = "fr";

  # Overriden by the flake (set to unstable)
  system.stateVersion = "24.05";
}
