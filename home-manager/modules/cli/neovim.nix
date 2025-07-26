# Neovim configuration
{ pkgs, ... }:
{
  # Image.nvim additional dependencies
  programs.neovim = {
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = with pkgs; [
      imagemagick
      ripgrep
      fd
    ];
  };
}
