# Just command helpers

help:
  echo "Helper commands to navigate NixOS configurations"

# Switch to a new NixOS generation
switch:
  sudo nixos-rebuild switch --flake .#main-laptop

# Switch my own home-manager config
thibaut:
  home-manager switch --flake .#thibaut

# Test a new NixOS generation
test:
  sudo nixos-rebuild test --flake .#main-laptop

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
  stow --target=$HOME/.local/bin scripts
  stow --dir dotfiles --target=$HOME/.config/Code/User vscode
  mkdir -p ~/.themes
  ln -s $(pwd)/dotfiles/gnome/Whiskers ~/.themes/Whiskers
   
# Update nixpkgs unstable
update-nixpkgs:
  nix flake update nixpkgs
