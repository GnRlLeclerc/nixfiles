# Wallpaper
{ pkgs, ... }:
# TODO : add my own wallpapers
{
  stylix = {
    image = pkgs.fetchurl {
      url = "https://zebreus.github.io/all-gnome-backgrounds/images/blobs-l-b49caff1a7941d98b60902da64956ad85dfbe4f9.webp";
      sha256 = "sha256-BQLBBmjMiblubFfN2lBZyzimurM380W8h4mBFwQy8mw=";
    };

  };
}
