# NixOS bootloader config
{ ... }:
{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 0; # Skip the bootloader menu unless a key is pressed
  };
}
