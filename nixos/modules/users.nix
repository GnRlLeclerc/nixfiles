# System users
{ config, lib, ... }:

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
      ];
    };
  };
}
