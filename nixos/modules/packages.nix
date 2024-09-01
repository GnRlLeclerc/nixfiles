# Default system packages
{ pkgs, ... }:
{
  programs.zsh.enable = true;

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
