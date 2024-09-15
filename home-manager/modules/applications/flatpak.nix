# Flatpak applications
{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "com.belmoussaoui.Authenticator"
    "com.github.unrud.VideoDownloader"
    "com.yubico.yubioath"
    "io.github.celluloid_player.Celluloid"
    "org.gnome.gitlab.YaLTeR.VideoTrimmer"
  ];
}
