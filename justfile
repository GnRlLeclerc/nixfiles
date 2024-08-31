# Just command helpers

help:
    echo "Helper commands to navigate NixOS configurations"

switch:
    sudo nixos-rebuild switch --flake .

test:
    sudo nixos-rebuild test   --flake .
