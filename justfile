# Just command helpers

help:
    echo "Helper commands to navigate NixOS configurations"

# Switch to a new NixOS generation
switch:
    sudo nixos-rebuild switch --flake .

# Test a new NixOS generation
test:
    sudo nixos-rebuild test --flake .

# Rollback to the previous NixOS generation
rollback:
    sudo nixos-rebuild switch --rollback --flake .
