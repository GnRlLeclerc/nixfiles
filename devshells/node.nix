# Standard nodejs shells
{
  pkgs,
  lib,
  ...
}:

let
  nodeVersions = with pkgs; [
    nodejs_18
    nodejs_20
    nodejs_22
  ];

  mkNodeShell =
    node:
    pkgs.mkShell {
      packages = [ node ];
    };

  # Create node shell names based on the major version
  # Example: node18, node20, node22
  mkShellName =
    node:
    let
      versionParts = lib.splitString "." node.version;
      major = builtins.elemAt versionParts 0;
    in
    "node${major}";

  # Merge all node shells into a single attribute set
  nodeShells = builtins.listToAttrs (
    map (node: {
      name = mkShellName node;
      value = mkNodeShell node;
    }) nodeVersions
  );
in
nodeShells
