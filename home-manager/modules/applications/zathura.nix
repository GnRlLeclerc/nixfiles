# Zathura configuration
{ ... }:
{
  programs.zathura = {
    options = {
      synctex = true;
      synctex-editor-command = "nvr --remote-silent +%{line} %{input}";
      selection-clipboard = "clipboard";

      recolor = true; # Color the pdf as well
    };

    extraConfig = ''
      include colors.conf
      map i recolor
      map p print
    '';
  };
}
