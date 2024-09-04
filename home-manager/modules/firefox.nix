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
      };

      # TODO: theming with native messaging
      programs.firefox.nativeMessagingHosts = [ ];

      # For gnome
      programs.firefox.enableGnomeExtensions = cfg.gnome;
      services.gnome.gnome-browser-connector.enable = cfg.gnome;
    };
  };
}
