# Custom base16 themes
let
  imports = map import [
    ./catppuccin.nix
    ./kanagawa.nix
    ./tokyonight.nix
  ];

in
builtins.foldl' (acc: scheme: acc // scheme) { } imports
