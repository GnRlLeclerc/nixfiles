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

    desktop.environment = mkOption {
      type = types.enum [
        "hyprland"
        "gnome"
      ];
      default = "gnome";
      description = "Choose a desktop environment";
    };
  };

  config = mkIf cfg.desktop.enable (mkMerge [
    {
      # Enable CUPS for printing
      services.printing.enable = true;

      # Hint at electron apps to run under wayland
      # NIXOS_OZONE_WL works as well
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    }

    #################################################
    #              Desktop environments             #
    #################################################

    (mkIf (cfg.desktop.environment == "gnome") {
      # NOTE: add https://extensions.gnome.org/extension/19/user-themes/ to enable custom stylix gnome theme

      # Enable Xorg
      services.xserver.enable = true;

      # Enable GNOME
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
      services.gnome.gnome-browser-connector.enable = true;

      # Configure Xorg keymap
      services.xserver.xkb = {
        layout = "fr";
        variant = "azerty";
      };

      # Gnome triple buffering patch: fix multi-monitors & mouse lag
      environment.sessionVariables.MUTTER_DEBUG_ENABLE_ATOMIC_KMS = "0";

      # Fix Gdk display
      environment.sessionVariables.GSK_RENDERER = "gl";

      # Fix video metadata
      environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
        lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
          [
            pkgs.gst_all_1.gst-plugins-good
            pkgs.gst_all_1.gst-plugins-bad
            pkgs.gst_all_1.gst-plugins-ugly
            pkgs.gst_all_1.gst-libav
          ];

      # Fix suspend/resume cycling because of nvidia power management
      # https://discourse.nixos.org/t/suspend-resume-cycling-on-system-resume/32322/12
      systemd = {
        services."gnome-suspend" = {
          description = "suspend gnome shell";
          before = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
            "nvidia-suspend.service"
            "nvidia-hibernate.service"
          ];
          wantedBy = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
          ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = ''${pkgs.procps}/bin/pkill -f -STOP ${pkgs.gnome-shell}/bin/gnome-shell'';
          };
        };
        services."gnome-resume" = {
          description = "resume gnome shell";
          after = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
            "nvidia-resume.service"
          ];
          wantedBy = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
          ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = ''${pkgs.procps}/bin/pkill -f -CONT ${pkgs.gnome-shell}/bin/gnome-shell'';
          };
        };
      };
    })

    (mkIf (cfg.desktop.environment == "hyprland") {
      # Enable Hyprland
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };

      # Use gnome keyring for secrets (needed for VSCode Copilot)
      services.gnome.gnome-keyring.enable = true;
      security.pam.services.login.enableGnomeKeyring = true; # load gnome-keyring at startup

      # Packages needed
      environment.systemPackages = with pkgs; [
        hypridle # Idle screen
        hyprlock # Lock screen
        waybar # Status bar
        udiskie # USB automount
        swww # Wallpaper
        clipse # Clipboard
        hyprpolkitagent # Polkit agent
        rose-pine-hyprcursor # Cursor
        pulseaudio # Audio control
      ];
    })
  ]);
}
