# Devshell for old / requirements.txt python environments
{ pkgs, ... }:
{
  # Python pyenv FHS environment to access old python versions, or use pip
  pyenv =
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
          ];
        in
        pkgs:
        (with pkgs; [
          pyenv
        ])
        ++ buildPkgs # Include the build libraries
        ++ (map (p: p.dev) buildPkgs); # Include the development headers
      runScript = "zsh";
    }).env;
}
