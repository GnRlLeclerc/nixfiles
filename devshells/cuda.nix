# Devshell for Egui applications
{ pkgs, ... }:
{
  cuda = pkgs.mkShell {
    # NOTE: issue with paths that have spaces in the names

    packages = with pkgs; [
      cudatoolkit
      gcc13 # gcc <= 13 for cuda
      cudaPackages.cuda_cudart
      cudaPackages.cuda_cudart.static
    ];

    CUDA_HOME = "${pkgs.cudatoolkit}";

    # NVIDIA drivers
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
  };
}
