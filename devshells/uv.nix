# Devshell for old / requirements.txt python environments
{ pkgs, ... }:
{
  # Python pyenv FHS environment to access old python versions, or use pip
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
        ])
        ++ buildPkgs # Include the build libraries
        ++ (map (p: p.dev) buildPkgs); # Include the development headers
      runScript = "zsh";

      profile = ''
        # Matplotlib backend
        export MPLBACKEND=GTK3Agg
      '';
    }).env;
}
