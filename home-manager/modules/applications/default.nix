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
    ./flatpak.nix
    ./firefox.nix
    ./miscellaneous.nix
    ./vscode.nix
    ./zathura.nix
  ];

  options.settings.desktop-applications.enable = mkEnableOption "Desktop applications";

  config = {
    programs.chromium.enable = mkDefault cfg.enable;
    programs.discord.enable = mkDefault cfg.enable;
    programs.firefox.enable = mkDefault cfg.enable;
    services.flatpak.enable = mkDefault cfg.enable;
    programs.vscode.enable = mkDefault cfg.enable;
    programs.zathura.enable = mkDefault cfg.enable;
  };
}
