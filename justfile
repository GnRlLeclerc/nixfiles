# Just command helpers

help:
  echo "Helper commands to navigate NixOS configurations"

# Switch to a new NixOS generation
switch:
  sudo nixos-rebuild switch --flake .#main-laptop
  just fix-all

# Switch my own home-manager config
thibaut:
  home-manager switch --flake .#thibaut
  just fix-all

# Test a new NixOS generation
test:
  sudo nixos-rebuild test --flake .#main-laptop
  just fix-all

# Rollback to the previous NixOS generation
rollback:
  sudo nixos-rebuild switch --rollback --flake .#main-laptop

# Remove all old nixos & home-manager generations, and collect garbage
prune: 
  home-manager expire-generations "-0 days"
  sudo nix-collect-garbage --delete-old  # Do not forget sudo, else it will not remove the old generations

# Symlink all dotfiles
symlink:
  stow --target=$HOME/.config dotfiles
   


# Read-write symlinks
fix-all:
  just fix-vscode-settings


# Make VSCode's settings and keybindings symlink point to this repository instead of a readonly derivation build
fix-vscode-settings:
  unlink ~/.config/Code/User/settings.json
  unlink ~/.config/Code/User/keybindings.json
  ln -s $(pwd)/home-manager/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
  ln -s $(pwd)/home-manager/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json

# Update nixpkgs unstable
update-nixpkgs:
  nix flake update nixpkgs
