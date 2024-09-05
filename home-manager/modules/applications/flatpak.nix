# Flatpak applications
{ inputs, ... }:
{
  imports = [ inputs.flatpaks.homeManagerModules.default ];

  services.flatpak.packages = [
    "flathub:apps/com.github.tchx84.Flatseal"
    "flathub:apps/com.belmoussaoui.Authenticator"
    "flathub:apps/com.github.unrud.VideoDownloader"
    "flathub:apps/com.yubico.yubioath"
    "flathub:apps/io.github.celluloid_player.Celluloid"
    "flathub:apps/org.gnome.gitlab.YaLTeR.VideoTrimmer"
  ];
}
