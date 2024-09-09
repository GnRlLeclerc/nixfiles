# Dockerfile language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.docker;
in
{
  options.settings.languages.docker.enable = mkEnableOption "Enable docker language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # LSP
      docker-compose-language-service
      dockerfile-language-server-nodejs
    ];
  };
}
