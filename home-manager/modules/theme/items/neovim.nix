# Neovim flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.neovim;
in
{
  options.programs.flavours.neovim = mkEnableOption "Enable neovim theming by flavours";

  config.programs.flavours.settings = mkIf cfg [
    {
      file = "${config.xdg.configHome}/nvim/lua/base16_colors.lua";
      template = "luakit";
      subtemplate = "colors";
      rewrite = true;
    }
  ];
}
