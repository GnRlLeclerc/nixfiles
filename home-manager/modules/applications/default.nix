# Import all application configurations (without activating them)
# Set `options.settings.cfg.enable-applications` to true to activate all applications
{ lib, config, ... }:

with lib;

let
  cfg = config.settings.desktop-applications;

in
{
  imports = [
    ./chromium.nix
    ./betterdiscord.nix
    ./fastfetch.nix
    ./flatpak.nix
    ./firefox.nix
    ./miscellaneous.nix
    ./spicetify.nix
    ./zathura.nix
  ];

  options.settings.desktop-applications.enable = mkEnableOption "Desktop applications";

  config = {
    programs.firefox.enable = mkDefault cfg.enable;
    programs.chromium.enable = mkDefault cfg.enable;
    programs.spicetify.enable = mkDefault cfg.enable;
    programs.fastfetch.enable = mkDefault cfg.enable;
    programs.zathura.enable = mkDefault cfg.enable;
    programs.discord.enable = mkDefault cfg.enable;
    services.flatpak.enableModule = mkDefault cfg.enable;
  };
}
