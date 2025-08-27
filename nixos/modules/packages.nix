# Default system packages
{ pkgs, ... }:
{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    just
    ncdu
    neovim
    nixfmt-rfc-style
    curl
    pciutils
    wget
    home-manager
    xkeyboard_config
    seahorse
  ];
}
