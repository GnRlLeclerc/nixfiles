{ pkgs, ... }:
{
  # Python pyenv FHS environment to access old python versions or use uv
  uv =
    (pkgs.buildFHSEnv {
      name = "pyenv FHS";
      targetPkgs =
        let
          buildPkgs = with pkgs; [
            # Build libraries
            zlib
            libffi
            readline
            bzip2
            openssl
            xz
            sqlite
            ncurses
            tk

            # Display libraries
            xorg.libX11
            libGLU
            libGL

            # PyGObject dependencies (matplotlib backend)
            cairo
            xorg.libxcb
            glib

            # BUG: these don't fix the gtk namespace not available error
            gobject-introspection
            gtk3
            glibc
          ];
        in
        pkgs:
        (with pkgs; [
          uv
          pkg-config

          # PyGobject
          xorg.xorgproto

          # CUDA
          cudatoolkit
          gcc13 # gcc <= 13 for cuda
          cudaPackages.cuda_cudart
        ])
        ++ buildPkgs # Include the build libraries
        ++ (map (p: p.dev) buildPkgs); # Include the development headers
      runScript = "fish";
      profile = ''
        export MPLBACKEND=GTK3Agg
        export CUDA_HOME="${pkgs.cudatoolkit}"
        export TORCH_CUDA_ARCH_LIST="8.6" # Compute capability of RTX 3050
        export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
      '';
    }).env;
}
