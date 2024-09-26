# VSCode configuration
{ pkgs, ... }:
{
  # Manage VSCode the usual way
  programs.vscode.package =
    (pkgs.vscode.override {
      # Add this flag to fix blurry vscode on wayland when using ozone & fractional scaling
      # See https://github.com/microsoft/vscode/issues/203303#issuecomment-1913443702
      commandLineArgs = [ "--disable-features=WaylandFractionalScaleV1" ];
    }).fhs;

  # Symlink the keybindings and settings in a readonly way
  xdg.configFile."Code/User" = {
    source = ../../dotfiles/vscode;
    recursive = true;
  };

}
