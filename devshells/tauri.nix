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

  # TODO: a tauri devshell based on archlinux docker for guaranteed prebuilt dependencies
  tauri-docker =
    pkgs.mkShell
      {
      };
}
