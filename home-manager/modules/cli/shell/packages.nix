# Useful shell packages
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.shell;
in
{
  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Basic cli
      gawk
      gnused
      jq

      # Fancy cli
      bat
      delta
      dotacat
      dust
      eza
      fastfetch
      fd
      fzf
      just
      lazygit
      lazydocker
      nvtopPackages.full
      procs
      ripgrep
      tldr
      zoxide
    ];
  };
}
