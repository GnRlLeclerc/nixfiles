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
          torch-bin
          scikit-learn

          # Image processing
          (opencv4.override { enableGtk3 = true; })
          pygobject3
        ]
      ))
    ];

    shellHook = ''
      # Make matplotlib use GTK3Agg backend
      export MPLBACKEND=GTK3Agg
    '';
  };
}
