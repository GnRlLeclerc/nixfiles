# VSCode configuration
{ pkgs, ... }:
{
  # Manage VSCode the usual way
  programs.vscode.package = pkgs.vscode-fhs;

  # Symlink the keybindings and settings in a readonly way
  xdg.configFile."Code/User" = {
    source = ../../dotfiles/vscode;
    recursive = true;
  };

}
