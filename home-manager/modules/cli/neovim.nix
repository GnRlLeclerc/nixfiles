# Useful default settings for neovim
{ pkgs, ... }:
{
  # Readonly symlink to the neovim dotfiles
  # The symlink is recursive to allow overriding the lazy-lock.json symlink to a writable file
  xdg.configFile.nvim = {
    source = ../../dotfiles/nvim;
    recursive = true;
  };

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
