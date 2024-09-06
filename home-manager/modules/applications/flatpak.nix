# Flatpak applications
{ inputs, ... }:
{
  imports = [ inputs.flatpaks.homeManagerModules.default ];

  services.flatpak.packages = [
    "flathub:app/com.github.tchx84.Flatseal//master"
    "flathub:app/com.belmoussaoui.Authenticator//master"
    "flathub:app/com.github.unrud.VideoDownloader//master"
    "flathub:app/com.yubico.yubioath//master"
    "flathub:app/io.github.celluloid_player.Celluloid//master"
    "flathub:app/org.gnome.gitlab.YaLTeR.VideoTrimmer//master"
  ];
}
