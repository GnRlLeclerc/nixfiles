# Node (& other web techs) language support
{
  config,
  lib,
  pkgs,
  unstable-pkgs,
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
      unstable-pkgs.typescript-language-server
      vscode-langservers-extracted
      tailwindcss-language-server
      unstable-pkgs.svelte-language-server

      # Formatter
      prettierd
    ];
  };
}
