# Python overlays
final: prev:
let
  # Import all python overlays
  overrides = map import [
    ./python-fixes.nix
    ./python-overrides.nix
    ./python-packages.nix
  ];

  # Extract their packageOverrides functions (which each accept finalPy and prevPy as args)
  packageOverrideFunctions = map (override: (override final prev).packageOverrides) overrides;
in

{
  python312 = prev.python312.override {
    packageOverrides =
      finalPy: prevPy:
      let
        # Merge all packageOverrides functions into a single function
        packageOverrides = builtins.foldl' (
          acc: override: acc // (override finalPy prevPy)
        ) { } packageOverrideFunctions;
      in
      packageOverrides;
  };

  python312Packages = final.python312.pkgs;
}
