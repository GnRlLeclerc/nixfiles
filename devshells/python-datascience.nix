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
          tensorboardx
          transformers
          scikit-learn
          scikit-image

          # Image processing
          (opencv4.override { enableGtk3 = true; })
          pygobject3

          # Jupyter notebooks
          ipykernel

          # Needed for tensorboardX
          protobuf

          # Utility
          ftfy
          regex
          tqdm
        ]
      ))
    ];

    shellHook = ''
      # Make matplotlib use GTK3Agg backend
      export MPLBACKEND=GTK3Agg
    '';
  };

  # Mamba shell for python
  # Images and GUIs do not work well
  mamba = pkgs.mkShell {
    buildInputs = with pkgs; [
      # Plotting with GTK backend
      gtk3
      gobject-introspection

      # GTK SVG image support
      librsvg

      # OpenCV Qt backend (does not work with matplotlib)
      qt6.qtbase

      # For cv2
      libglvnd
    ];

    packages = with pkgs; [
      micromamba
    ];
    shellHook = ''
      # Expose CUDA drivers to python
      # https://discourse.nixos.org/t/installing-pytorch-into-a-virtual-python-environment/34720/2
      export NIX_LD_LIBRARY_PATH=/run/opengl-driver/lib

      # Expose libgl for cv2
      export NIX_LD_LIBRARY_PATH=${pkgs.libglvnd}/lib:$NIX_LD_LIBRARY_PATH

      # Export Qt platform plugins for cv2 & matplotlib windows
      # https://discourse.nixos.org/t/python-qt-qpa-plugin-could-not-find-xcb/8862/3
      export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt6.qtbase}/lib/qt-6/plugins/platforms";

      # Make matplotlib use GTK3 backend
      # export MPLBACKEND=GTK3agg
      export MPLBACKEND=TKAgg
    '';
  };
}
