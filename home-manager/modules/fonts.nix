# Some cool fonts
{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  # Nerd fonts
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "CascadiaCode"
      ];
    })
  ];
}
