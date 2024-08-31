# Desktop environment features and applications (apps, sound, graphics)
{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    desktop.enable = mkEnableOption "Desktop environment features and applications";

    desktop.environment = mkOption {
      type = types.str;
      default = "gnome-xorg";
      description = "Choose a desktop environment: \"hyprland\"|\"gnome-wayland\"|\"gnome-xorg\"";
      example = "hyprland";
    };
  };

  config = mkIf config.desktop.enable {
    programs.firefox.enable = true;   


  # Enable CUPS to print documents.
  services.printing.enable = true;

    # Other desktop applications
    environment.systemPackages = with pkgs; [
      kitty
      slack
      obsidian
    ];

    ########################
    # Desktop environments #
    ########################

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
  };
}
