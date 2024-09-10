# Useful default settings for neovim
{
  # Readonly symlink to the neovim dotfiles
  # The symlink is recursive to allow overriding the lazy-lock.json symlink to a writable file
  xdg.configFile.nvim = {
    source = ../../dotfiles/nvim;
    recursive = true;
  };
}
