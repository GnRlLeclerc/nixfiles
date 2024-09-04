# Firefox module with default settings
# TODO
# https://github.com/vimjoyer/nix-firefox-video
# https://gitlab.com/usmcamp0811/dotfiles/-/blob/fb584a888680ff909319efdcbf33d863d0c00eaa/modules/home/apps/firefox/default.nix
# https://github.com/Misterio77/nix-config/blob/6390e833ee8802952a26f7724dc4c1248775c72b/home/gabriel/features/desktop/common/firefox.nix#L7
{
  inputs,
  config,
  lib,
  ...
}:

with lib;

let

  cfg = config.settings.firefox;

in
{
  options.settings.firefox = {
    # Base options
    user = {
      type = types.str;
      default = "thibaut";
      description = "The user profile name";
    };

    system = {
      type = types.str;
      default = "x86_64-linux";
      description = "The system for which firefox extensions are preinstalled";
    };

    gnome = mkEnableOption "Enable gnome integration";

    # Bookmark group options
    bookmarks = {
      google = mkEnableOption "Enable google bookmarks";
      polytechnique = mkEnableOption "Enable polytechnique bookmarks";
      telecom = mkEnableOption "Enable telecom bookmarks";
      nix = mkEnableOption "Enable nix bookmarks";
    };
  };

  config = mkIf config.programs.firefox.enable {

    programs.firefox = {
      profiles."${cfg.user}" = {

        extensions = with inputs.firefox-addons.packages."${cfg.system}"; [
          bitwarden
          ublock-origin
          darkreader
          return-youtube-dislikes
          foxyproxy-standard
        ];

        # Useful bookmarks with default priority
        bookmarks = mkMerge [
          (mkIf cfg.bookmarks.google [
            {
              name = "Gmail";
              tags = [ "gmail" ];
              keyword = "gmail";
              url = "https://mail.google.com/mail";
            }
            {
              name = "Drive";
              tags = [ "drive" ];
              keyword = "drive";
              url = "https://drive.google.com/drive/my-drive";
            }
            {
              name = "Agenda";
              tags = [ "agenda" ];
              keyword = "agenda";
              url = "https://calendar.google.com/calendar";
            }
          ])

          (mkIf cfg.bookmarks.polytechnique [
            {
              name = "Sigma";
              tags = [ "sigma" ];
              keyword = "sigma";
              url = "https://sigma.binets.fr/app/home";
            }
            {
              name = "Gitlab";
              tags = [ "gitlab" "polytechnique" "br" ];
              keyword = "gitlab";
              url = "https://gitlab.binets.fr";
            }
            {
              name = "Ximbra";
              tags = [ "zimbra" "polytechnique" ];
              keyword = "zimbra";
              url = "https://webmail.polytechnique.fr";
            }
          ])

          (mkIf cfg.bookmarks.nix [
            {
              name = "Noogle";
              tags = [ "noogle" "nix" ];
              keyword = "noogle";
              url = "https://noogle.dev";
            }
            {
              name = "Nix Flake Book";
              tags = [ "nix" "flakes" "book" ];
              keyword = "nix flakes book";
              url = "https://nixos-and-flakes.thiscute.world";
            }
          ])

          (mkIf cfg.bookmarks.telecom [
            {
              name = "Synapses Télécom";
              tags = [ "synapses" "télécom" ];
              keyword = "synapses telecom";
              url = "https://synapses.telecom-paris.fr";
            }
            {
              name = "Eole";
              tags = [ "eole" "telecom" ];
              keyword = "eole telecom";
              url = "https://eole.telecom-paris.fr";
            }
            {
              name = "Timbra";
              tags = [ "zimbra" "telecom" ];
              keyword = "zimbra";
              url = "https://z.imt.fr/zimbra/mail";
            }
            {
              name = "ECampus";
              tags = [ "ecampus" "telecom" ];
              keyword = "ecampus telecom";
              url = "https://ecampus.paris-saclay.fr/course/index.php?categoryid=573";
            }
          ])
        ];
      };

      # TODO: theming with native messaging
      programs.firefox.nativeMessagingHosts = [ ];

      # For gnome
      programs.firefox.enableGnomeExtensions = cfg.gnome;
      services.gnome.gnome-browser-connector.enable = cfg.gnome;
    };
  };
}
