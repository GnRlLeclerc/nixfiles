# Default system packages
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    just
    ncdu
    neovim
    nixfmt-rfc-style
    curl
    pciutils
    wget
  ];
}
