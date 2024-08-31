# Desktop environment features and applications (apps, sound, graphics)
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.settings;
in {
  options.settings = {
    desktop.enable = mkEnableOption "Desktop environment features and applications";

    desktop.environment = mkOption {
      type = types.enum ["hyprland" "gnome" ];
      default = "gnome-xorg";
      description = "Choose a desktop environment";
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
        
	# Libre Office fresh + spellcheck
	libreoffice-fresh
        hunspell
	hunspellDicts.fr-any
	hunspellDicts.en-us
	hunspellDicts.en-gb-ise
      ];
    }


    #################################################
    #              Desktop environments             #
    #################################################

    (mkIf (cfg.desktop.environment == "gnome") {
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

    (mkIf (cfg.desktop.environment == "hyprland") {
      # hyprland
      # TODO : hyprland
    })
  ]);
}
