# Devshell for Egui applications
{ pkgs, ... }:
{
  cuda = pkgs.mkShell {

    packages = with pkgs; [
      cudatoolkit
      gcc13 # gcc <= 13 for cuda
      cudaPackages.cuda_cudart
      cudaPackages.cuda_cudart.static
    ];

    CPLUS_INCLUDE_PATH = "${pkgs.cudatoolkit}/include";
  };
}
