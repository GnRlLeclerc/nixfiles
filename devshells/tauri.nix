# Devshell for tauri applications development
{ pkgs, ... }:
let
  makePkgConfigPath = pkgs.lib.makeSearchPathOutput "out" "lib/pkgconfig";
in
{
  # Recommended tauri setup (NixOS prerequisite)
  # https://v2.tauri.app/start/prerequisites/
  tauri = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      at-spi2-atk
      atkmm
      cairo
      gdk-pixbuf
      glib
      gobject-introspection
      gobject-introspection.dev
      gtk3
      harfbuzz
      librsvg
      libsoup_3
      pango
      webkitgtk_4_1
      webkitgtk_4_1.dev

      # Additional libraries not mentionned
      openssl
      libsysprof-capture
      libthai
      libdatrie
      libselinux
      lerc
      libsepol
      xorg.libXdmcp
      util-linux.dev
      pcre2
      sqlite
      libpsl
      libxkbcommon
      libepoxy
      xorg.libXtst
      nghttp2

      # Appimage build dependencies (still bugged, disabled)
      # libz
      # libstdcxx5
      # xorg.libX11
      # fontconfig
      # freetype
      # xorg.libxcb
      # libdrm
      # mesa
      # expat
      # libgpg-error
      # fribidi
      # harfbuzz
      # libGL
    ];

    # Required for pkg-config to find the libraries
    packages = with pkgs; [
      pkgconf
    ];

    # https://github.com/tauri-apps/tauri/issues/8929
    NO_STRIP = "true";

    PKG_CONFIG_PATH =
      with pkgs;
      makePkgConfigPath [
        glib.dev
        libsoup_3.dev
        webkitgtk_4_1.dev
        at-spi2-atk.dev
        gtk3.dev
        gdk-pixbuf.dev
        cairo.dev
        pango.dev
        harfbuzz.dev
      ];

    # Appimage build time dependencies
    # LD_LIBRARY_PATH =
    #   with pkgs;
    #   pkgs.lib.makeLibraryPath [
    #     libz
    #     libstdcxx5
    #     xorg.libX11
    #     fontconfig
    #     freetype
    #     xorg.libxcb
    #     libdrm
    #     mesa
    #     expat
    #     libgpg-error
    #     fribidi
    #     harfbuzz
    #     libGL
    #   ];
  };

  # A tauri devshell based on archlinux docker for guaranteed prebuilt dependencies
  # NOTE: not used anymore, but kept for reference on docker shells
  tauri-docker = pkgs.mkShell {
    shellHook = ''
      image_tag=tauri-docker-dev

      if ! docker images | grep $image_tag; then
        echo "Building tauri devshell image"
        docker build -t tauri-docker-dev \
          --build-arg HOST_USER_ID="$(id -u)" \
          --build-arg HOST_USER_NAME="$(whoami)" \
          --build-arg HOST_GROUP_ID="$(id -g)" \
          --build-arg HOST_GROUP_NAME="$(id -gn)" \
          --file ${../home-manager/dotfiles/docker/tauri.dockerfile} \
          .
      fi

      echo "Running tauri devshell"
      docker run -e XDG_RUNTIME_DIR=/tmp \
        -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
        -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY  \
        -v cargo_cache:/home/$(whoami)/.cargo \
        -it -v $(pwd):/home/$(whoami)/development tauri-docker-dev /bin/bash
    '';
  };
}
