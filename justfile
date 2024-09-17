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

# Read-write symlinks

# Make Neovim's lazy-lock.json file symlink point to this repository instead of a readonly derivation build
fix-neovim-lockfile:
    unlink ~/.config/nvim/lazy-lock.json
    ln -s $(pwd)/home-manager/dotfiles/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json

# Make VSCode's settings and keybindings symlink point to this repository instead of a readonly derivation build
fix-vscode-settings:
    unlink ~/.config/Code/User/settings.json
    unlink ~/.config/Code/User/keybindings.json
    ln -s $(pwd)/home-manager/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
    ln -s $(pwd)/home-manager/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json

# Update nixpkgs unstable
update-nixpkgs:
    nix flake lock --update-input nixpkgs
