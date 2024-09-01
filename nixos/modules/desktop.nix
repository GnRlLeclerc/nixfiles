# Desktop environment features and applications (apps, sound, graphics)
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
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
        # TODO : ne pas mettre ces packages ici, mais uniquement dans home manager. Ça sert à rien de dédoubler.
        kitty
        slack
        obsidian
        vscode-fhs

        # Libre Office fresh + spellcheck
        libreoffice-fresh
        hunspell
        hunspellDicts.fr-any
        hunspellDicts.en-us
        hunspellDicts.en-gb-ise

        # Backlight control
        brightnessctl

        # Sound control
        playerctl

        # Wayland clipboard utilities
        wl-clipboard
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

      # Gnome triple buffering patch: fix multi-monitors & mouse lag
      environment.sessionVariables.MUTTER_DEBUG_ENABLE_ATOMIC_KMS = "0";
    })

    (mkIf (cfg.desktop.environment == "hyprland") {
      # TODO : hyprland
      # Maybe do this in home-manager instead. See how to handle the login screen, then
    })
  ]);
}
