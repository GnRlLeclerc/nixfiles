# Desktop environment features and applications (apps, sound, graphics)
{
  config,
  lib,
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
    }

    #################################################
    #              Desktop environments             #
    #################################################

    (mkIf (cfg.desktop.environment == "gnome") {
      # NOTE: add https://extensions.gnome.org/extension/19/user-themes/ to enable custom stylix gnome theme

      # Enable Xorg
      services.xserver.enable = true;

      # Enable GNOME
      services.xserver.displayManager.gdm.enable = true;
      services.xserver.desktopManager.gnome.enable = true;
      services.gnome.gnome-browser-connector.enable = true;

      # Configure Xorg keymap
      services.xserver.xkb = {
        layout = "fr";
        variant = "azerty";
      };

      # Gnome triple buffering patch: fix multi-monitors & mouse lag
      environment.sessionVariables.MUTTER_DEBUG_ENABLE_ATOMIC_KMS = "0";

      # Hint at electron apps to run under wayland
      # NIXOS_OZONE_WL works as well
      environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
    })

    (mkIf (cfg.desktop.environment == "hyprland") {
      # TODO : hyprland
      # Maybe do this in home-manager instead. See how to handle the login screen, then
    })
  ]);
}
