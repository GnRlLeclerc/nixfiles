# CUDA & NVIDIA GPU support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.cuda;
in
{
  options.settings.languages.cuda.enable = mkEnableOption "Enable CUDA & NVIDIA support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      cudatoolkit
      cudaPackages.cuda_cudart
    ];
  };
}
