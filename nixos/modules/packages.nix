# Default system packages
{ ... }:
{
  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
    wget
    just
  ];
}
