{ pkgs, inputs, ... }:

with inputs;

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

    packages =
      with pkgs;
      [
      ];
  };

  programs.git = {
    enable = true;
    userEmail = "thibaut2saivre@gmail.com";
    userName = "Thibaut";
  };

  # Neovim: readonly symlink to my config (TODO: use nixvim or something like that for proper version handling)
  # TODO: provide luarocks in the new config for magick (do it in a module)
  programs.neovim.enable = true;
  xdg.configFile."nvim".source = ../dotfiles/nvim;
}
