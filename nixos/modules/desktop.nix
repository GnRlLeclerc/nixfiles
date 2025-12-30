# Desktop environment features and applications (apps, sound, graphics)
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  # TODO: celluloid sound issue: https://github.com/celluloid-player/celluloid/issues/506#issuecomment-2425581455
  cfg = config.settings;
in
{
  options.settings = {
    desktop.enable = mkEnableOption "Desktop environment features and applications";
  };

  config = mkIf cfg.desktop.enable {
    # Enable CUPS for printing
    services.printing.enable = true;

    # Hint at electron apps to run under wayland
    # NIXOS_OZONE_WL works as well
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    #####################################################
    #                         NIRI                      #
    #####################################################

    # Also enables gnome portal and gnome keyring
    programs.niri.enable = true;
    programs.dms-shell.enable = true; # Dank Material Shell
    # Greetd for autologin + immediately run hyprlock
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          command = "niri-session";
          user = "thibaut";
        };
      };
    };

    # Packages needed
    environment.systemPackages = with pkgs; [
      niri
      xwayland-satellite
      hypridle # Idle screen
      hyprlock # Lock screen
      waybar # Status bar
      udiskie # USB automount
      swww # Wallpaper
      hyprpolkitagent # Polkit agent
      rose-pine-cursor # Cursor
      pulseaudio # Audio control
      eog # Gnome image viewer
    ];
  };
}
