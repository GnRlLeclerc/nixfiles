# Devshells configuration
{
  nixpkgs,
  nixpkgs-stable,
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
        overlays = overlays.unstable;
      };

      # Define unstable packages with overlays
      stable-pkgs = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = overlays.stable;
      };

      # Process devshell files
      imports = map (file: import file { inherit pkgs stable-pkgs; }) [
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
