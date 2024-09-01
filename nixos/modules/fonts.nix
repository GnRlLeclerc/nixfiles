# Some cool fonts
{ pkgs, ... }:
{
  # Nerd fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "CascadiaCode"
      ];
    })
  ];
}
