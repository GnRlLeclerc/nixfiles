# Neovim theme configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.stylix.targets.neovim;
in
{
  config = mkIf (cfg.enable && config.programs.neovim.enable) {
    xdg.configFile."nvim/lua/plugins/theme.lua".text = lib.mkMerge [
      ''
        return {
          'RRethy/base16-nvim',
          config = function()
      ''
      (with config.lib.stylix.colors.withHashtag; ''
        require('base16-colorscheme').setup({
          base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
          base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
          base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
          base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
        })
      '')
      (lib.mkIf cfg.transparentBackground.main ''
        vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
        vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })
      '')
      (lib.mkIf cfg.transparentBackground.signColumn ''
        vim.cmd.highlight({ "SignColumn", "guibg=NONE", "ctermbg=NONE" })
      '')
      ''
        end,
        }''
    ];
  };
}
