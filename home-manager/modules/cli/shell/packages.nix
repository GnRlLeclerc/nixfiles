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
      bind
      cloc

      # Fancy cli
      bat
      # cava  # BUG: broken
      cmatrix
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
      nix-diff
      nix-output-monitor
      nvtopPackages.full
      procs
      ripgrep
      tldr
      zoxide

      # Caching
      cachix
    ];
  };
}
