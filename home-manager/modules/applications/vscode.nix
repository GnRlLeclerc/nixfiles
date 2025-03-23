# VSCode configuration
_: {
  # Symlink the keybindings and settings in a readonly way
  xdg.configFile."Code/User" = {
    source = ../../dotfiles/vscode;
    recursive = true;
  };

}
