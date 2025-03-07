# System users
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings;
in
{
  options.settings.me.enable = mkEnableOption "Add my user";

  config = mkIf cfg.me.enable {
    users.users.thibaut = {
      isNormalUser = true;
      description = "Thibaut";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
    };
    nix.settings.trusted-users = [ "thibaut" ];
  };
}
