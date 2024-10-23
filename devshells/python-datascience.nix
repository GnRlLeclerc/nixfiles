# Main python datascience devshell
{ pkgs, ... }:
{
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
      (python311.withPackages (
        ps: with ps; [
          # Basic
          numpy
          pandas
          polars

          # Plotting
          matplotlib
          seaborn

          # Deep learning
          tensorboardx
          torch-bin
          torchvision-bin
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
}
