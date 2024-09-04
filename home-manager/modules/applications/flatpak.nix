# Flatpak applications
{ inputs, ... }:
{
  imports = [ inputs.flatpaks.homeManagerModules.default ];
}
