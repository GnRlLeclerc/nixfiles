# Devshells configuration
{
  nixpkgs,
  nixpkgs-unstable,
  forAllSystems,
  inputs,
  overlays,
  ...
}:
let
  # For every system, merge all devshells and inject system-specific packages
  devShells = forAllSystems (
    system:
    let
      # Define standard packages with overlays
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = overlays.stable;
      };

      # Define unstable packages with overlays
      unstable-pkgs = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = overlays.unstable;
      };

      # Process devshell files
      imports = map (file: import file { inherit pkgs unstable-pkgs; }) [
        ./node.nix
        ./python-datascience.nix
        ./python.nix
        ./tauri.nix
      ];
    in
    # Merge all devshell attribute sets into a single one
    builtins.foldl' (acc: shell: acc // shell) { } imports
  );
in
devShells
