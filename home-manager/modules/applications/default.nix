# Import all application configurations (without activating them)
# Set `options.settings.desktop-applications` to true to activate all applications
{ lib, ... }:

with lib;

let
  desktop = config.settings.desktop-applications;

in
{
  imports = [
    ./chromium.nix
    ./fastfetch.nix
    ./firefox.nix
    ./miscellaneous.nix
    ./spicetify.nix
    ./zathura.nix
  ];

  options.settings.desktop-applications = mkEnableOption "Desktop applications";

  config = {
    programs.firefox.enable = mkDefault desktop;
    programs.chromium.enable = mkDefault desktop;
    programs.spicetify.enable = mkDefault desktop;
    programs.fastfetch.enable = mkDefault desktop;
    programs.zathura.enable = mkDefault desktop;
    programs.discord.enable = mkDefault desktop;
  };
}
