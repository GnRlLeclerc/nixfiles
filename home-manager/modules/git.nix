# Useful default git settings
{ lib, ... }:

with lib;

{
  programs = {
    delta = {
      enable = mkDefault true;
      enableGitIntegration = mkDefault true;
      options = {
        features = mkDefault "decorations";
        dark = mkDefault true;
        side-by-side = mkDefault true;

        interactive.keep-plus-minus-markers = mkDefault false;

        decorations = {
          commit-decoration-style = mkDefault "blue ol";
          commit-style = mkDefault "raw";
          file-style = mkDefault "omit";
          hunk-header-decoration-style = mkDefault "blue box";
          hunk-header-file-style = mkDefault "red";
          hunk-header-line-number-style = mkDefault "#067a00";
          hunk-header-style = mkDefault "file line-number syntax";
        };
      };
    };

    git = {
      lfs.enable = mkDefault true;
    };
  };
}
