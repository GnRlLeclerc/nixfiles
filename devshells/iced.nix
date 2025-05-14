# Devshell for iced applications development
{ pkgs, ... }:
let
  makeConcatPath = suffix: paths: pkgs.lib.concatMapStringsSep ":" (string: string + suffix) paths;
  makeLDLibraryPath = makeConcatPath "/lib";
in
{
  # https://github.com/rust-windowing/winit/issues/3603
  iced = pkgs.mkShell rec {
    buildInputs = with pkgs; [
      xorg.libX11
      xorg.libXcursor
      xorg.libxcb
      xorg.libXi
      libxkbcommon
      wayland
    ];
    # Runtime dependencies
    LD_LIBRARY_PATH = makeLDLibraryPath buildInputs;
  };
}
