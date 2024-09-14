# Standard python devshells for multiple versions
# Many libraries are included for seamless use in venvs
{
  pkgs,
  lib,
  ...
}:

let
  pythonVersions = with pkgs; [
    python39
    python310
    python311
    python312
    python313
  ];

  mkPythonShell =
    python:
    pkgs.mkShell {
      # Necessary 3rd party libraries for some python packages
      buildInputs = with pkgs; [
        stdenv.cc.cc
        zlib
      ];

      packages = [ python ];

      shellHook = ''
        # Necessary library paths for some python packages
        export LD_LIBRARY_PATH=${pkgs.zlib}/lib:${pkgs.stdenv.cc.cc.lib}/lib
      '';

    };

  # Create python shell names based  on the major and minor version
  # Example: python39, python310, python311, python312, python313
  mkShellName =
    python:
    let
      versionParts = lib.splitString "." python.version;
      major = builtins.elemAt versionParts 0;
      minor = builtins.elemAt versionParts 1;
    in
    "python${major}${minor}";

  # Merge all python shells into a single attribute set
  mergedShells = builtins.foldl' (
    acc: python: acc // { "${mkShellName python}" = mkPythonShell python; }
  ) { } pythonVersions;

in
mergedShells
