# Devshell for Slint and wayland
{ pkgs, ... }:
{
  slint = pkgs.mkShell rec {
    buildInputs = with pkgs; [
      libGL
      libxkbcommon
      wayland
      fontconfig
      pkg-config
      slint-lsp
    ];
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
  };
}
