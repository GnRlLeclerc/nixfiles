{ ... }:

{
  imports = [
    ../base-home.nix
  ];

  ##########################
  # Miscellaneous settings #
  ##########################

  # User management
  home = {
    username = "thibaut";
    homeDirectory = "/home/thibaut";
  };

  programs.git = {
    enable = true;
    userEmail = "thibaut2saivre@gmail.com";
    userName = "Thibaut";
  };

  # Enable all desktop applications
  settings.desktop-applications.enable = true;
  programs.kitty.enable = true;

  # Enable all cli applications
  settings.cli.enable = true;

  # Programming languages support
  settings.languages.enable = true;
}
