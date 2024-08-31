# Desktop environment features and applications (apps, sound, graphics)
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.settings;
in {
  options.settings = {
    desktop.enable = mkEnableOption "Desktop environment features and applications";

    desktop.environment = mkOption {
      type = types.enum ["hyprland" "gnome-wayland" "gnome-xorg" ];
      default = "gnome-xorg";
      description = "Choose a desktop environment: \"hyprland\"|\"gnome-wayland\"|\"gnome-xorg\"";
    };
  };

  config = mkIf cfg.desktop.enable (mkMerge [
    {
      # Enable CUPS for printing
      services.printing.enable = true;

      # Desktop programs
      programs.firefox.enable = true;   

      environment.systemPackages = with pkgs; [
        kitty
        slack
        obsidian
      ];
    }


    #################################################
    #              Desktop environments             #
    #################################################

    (mkIf (cfg.desktop.environment == "gnome-xorg") {
      # Enable Xorg
      services.xserver.enable = true;

      # Enable GNOME
      services.xserver.displayManager.gdm.enable = true;
      services.xserver.desktopManager.gnome.enable = true;

      # Configure Xorg keymap
      services.xserver.xkb = {
        layout = "us";
        variant = "intl";
      };
    })

  ]);
}
