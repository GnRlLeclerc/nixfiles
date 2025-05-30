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
        ps: with ps; [
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
          # outlines  # Update is on the way: https://github.com/NixOS/nixpkgs/pull/357313

          # Image processing
          (opencv4.override {
            enableGtk3 = true;
            enableCuda = false;
          })
          pygobject3

          # Jupyter notebooks
          ipykernel
          pip
          notebook

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
    MPLBACKEND = "GTK3Agg"; # Make matplotlib use GTK3Agg backend
    TORCH_CUDA_ARCH_LIST = "8.6"; # Compute capability of RTX 3050
    CUDA_HOME = pkgs.cudatoolkit;
  };
}
