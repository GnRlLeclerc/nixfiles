# Firefox flavours configuration
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.flavours.firefox;
in
{
  options.programs.flavours.firefox = mkEnableOption "Enable firefox theming by flavours";

  config = mkIf cfg {

    programs.flavours.settings = [
      {
        file = "${config.home.homeDirectory}/.mozilla/colors.toml";
        template = "colors";
        subtemplate = "toml";
        rewrite = true;
      }
    ];

    # Install the native messaging host
    home.packages = with pkgs; [
      firefox-native-base16
    ];

    # Create a wrapper script to run the native messaging host (else it does not work)
    home.file.".mozilla/native-messaging-scripts/firefox_native_base16" = {
      text = ''
        #!/usr/bin/env bash

        trap 'kill -TERM $native_pid' TERM
        ${pkgs.firefox-native-base16}/bin/firefox-native-base16 &
        native_pid=$!
        wait $native_pid
      '';
      executable = true;
    };

    # Native messaging manifest
    home.file.".mozilla/native-messaging-hosts/firefox_native_base16.json".text = builtins.toJSON {
      name = "firefox_native_base16";
      description = "Native messaging application to dynamically communicate base16 colorschemes to Firefox";
      type = "stdio";
      path = "${config.home.homeDirectory}/.mozilla/native-messaging-scripts/firefox_native_base16";
      allowed_extensions = [ "dynamic_base16@gnrl_leclerc.org" ];
    };
  };
}
