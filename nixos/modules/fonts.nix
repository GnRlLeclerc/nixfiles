# Install fonts system-wide for flatpak apps
{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    cantarell-fonts
  ];
}
