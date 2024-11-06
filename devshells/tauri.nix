# Devshell for tauri applications development
{ pkgs, ... }:
{
  # Recommended tauri setup (NixOS prerequisite)
  # https://v2.tauri.app/start/prerequisites/
  # ISSUE: takes a very long time to build (notably webkitgtk_4_1, which must be built with 1 job to avoid crashing)
  # Not viable on small systems (not enough packages are cached)
  tauri = pkgs.mkShell {
    buildInputs = with pkgs; [
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
      # PB : is it built on stable ?
      webkitgtk_4_1
      webkitgtk_4_1.dev
    ];

    PKG_CONFIG_PATH =
      with pkgs;
      "${glib.dev}/lib/pkgconfig:${libsoup_3.dev}/lib/pkgconfig:${webkitgtk_4_1.dev}/lib/pkgconfig:${at-spi2-atk.dev}/lib/pkgconfig:${gtk3.dev}/lib/pkgconfig:${gdk-pixbuf.dev}/lib/pkgconfig:${cairo.dev}/lib/pkgconfig:${pango.dev}/lib/pkgconfig:${harfbuzz.dev}/lib/pkgconfig";
  };

  # A tauri devshell based on archlinux docker for guaranteed prebuilt dependencies
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
