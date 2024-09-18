# Plymouth configuration
{ pkgs, ... }:

let
  theme = "spinner_alt";
in
{
  boot.plymouth = {
    enable = true;

    inherit theme;
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ theme ];
      })
    ];
  };

  boot = {
    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
