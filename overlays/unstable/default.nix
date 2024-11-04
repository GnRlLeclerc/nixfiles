# All overlays for the unstable nixpkgs
let
  # Import all overlay lists
  overlays = builtins.concatLists (
    map import [
      ./package-fixes.nix
      ./python/default.nix
    ]
  );
in
overlays
