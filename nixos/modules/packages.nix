# Default system packages
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
    wget
    just
  ];
}
