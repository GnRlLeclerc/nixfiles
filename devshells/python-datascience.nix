# Main python datascience devshell
{ pkgs, ... }:
{
  # Generic python datascience shell with preinstalled packages
  # Prefer this over mamba shell for GUIs and images
  datascience = pkgs.mkShell {
    buildInputs = with pkgs; [
      # For Numpy, Torch, etc.
      stdenv.cc.cc
      zlib

      # Plotting with GTK backend
      gtk3
      gobject-introspection

      # GTK SVG image support
      librsvg
    ];

    packages = with pkgs; [
      # Build system for loading C++ extensions in torch
      ninja
      cudatoolkit

      (python312.withPackages (
        ps:
        with ps;
        let
          opencvWithGtk = opencv4.override { enableGtk3 = true; };
        in
        [
          # Basic
          numpy
          pandas
          polars

          # Plotting
          matplotlib
          seaborn

          # Deep learning
          torch
          torchvision
          torchaudio
          transformers
          scikit-learn
          scikit-image
          (lpips.override { opencv4 = opencvWithGtk; })

          # Image processing
          opencvWithGtk
          pygobject3

          # Jupyter notebooks
          ipykernel

          # Python jit compiler
          numba

          # Utility
          ftfy
          regex
          tqdm
          rich
          click
        ]
      ))
    ];

    shellHook = ''
      # Make matplotlib use GTK3Agg backend
      export MPLBACKEND=GTK3Agg

      # For custom CUDA plugins that have to be compiled
      export CUDA_HOME=${pkgs.cudatoolkit}
      export TORCH_CUDA_ARCH_LIST="8.6"  # Compute capability of RTX 3050
    '';
  };
}
