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


# Make Neovim's lazy-lock.json file symlink point to this repository instead
fix-neovim-lockfile:
    unlink ~/.config/nvim/lazy-lock.json
    ln -s $(pwd)/home-manager/dotfiles/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json
