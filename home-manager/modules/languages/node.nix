# Node (& other web techs) language support
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.languages.node;
in
{
  options.settings.languages.node.enable = mkEnableOption "Enable node language support";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # Language (latest LTS node version)
      nodejs

      # Package managers
      yarn-berry
      bun
      pnpm

      # LSP
      vscode-langservers-extracted
      tailwindcss-language-server
      svelte-language-server

      # Formatter
      prettierd
    ];
  };
}
