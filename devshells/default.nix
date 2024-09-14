# Devshells configuration
{ nixpkgs, forAllSystems, ... }:
let
  # For every system, merge all devshells and inject system-specific packages
  devShells = forAllSystems (
    system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    builtins.foldl' (acc: shell: acc // shell pkgs) { } imports
  );

  # Devshell modules
  imports = map import [
    ./node.nix
    ./python-datascience.nix
    ./python.nix
  ];

in
devShells
