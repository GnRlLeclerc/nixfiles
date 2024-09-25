# Color scheme configuration
{ pkgs, ... }:
{
  stylix = {
    # Dark mode
    polarity = "dark";

    # See https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
  };
}
