# Main python datascience devshell
{ pkgs, ... }:
{
  datascience = pkgs.mkShell {
    buildInputs = with pkgs; [
      stdenv.cc.cc
      zlib
    ];

    packages = with pkgs; [
      (python311.withPackages (
        ps: with ps; [
          numpy
          pandas
          matplotlib
          seaborn
          scikit-learn
        ]
      ))
    ];

    shellHook = ''
      # for PyTorch
      export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib

      # for Numpy
      export LD_LIBRARY_PATH=${pkgs.zlib}/lib:$LD_LIBRARY_PATH
    '';
  };
}
