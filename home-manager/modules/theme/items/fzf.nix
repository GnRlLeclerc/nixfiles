# Fzf flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.fzf;
in
{
  options.programs.flavours.fzf = mkEnableOption "Enable fzf theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/zsh/fzf-colors.zsh";
        template = "fzf";
        subtemplate = "base16-default";
        rewrite = true;
      }
    ];

    # Load the base16 theme via zsh
    zsh.initExtra = ''
      source ${config.xdg.configHome}/zsh/fzf-colors.zsh
    '';
  };
}
