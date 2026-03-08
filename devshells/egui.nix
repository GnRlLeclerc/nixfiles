# Devshell for Egui applications
{ pkgs, ... }:
{
  egui = pkgs.mkShell rec {
    buildInputs = with pkgs; [
      libxkbcommon
      libGL

      # WINIT_UNIX_BACKEND=wayland
      wayland

      # WINIT_UNIX_BACKEND=x11
      libXcursor
      libXrandr
      libXi
      libX11
    ];
    LD_LIBRARY_PATH = with pkgs; "${lib.makeLibraryPath buildInputs}";
  };
}
