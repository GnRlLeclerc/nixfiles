# Obsidian theme configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.stylix.targets.obsidian;
in
{
  options.stylix.targets.obsidian = {
    enable = config.lib.stylix.mkEnableTarget "Obsidian" true;
    vaults = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Obsidian vault paths (relative to the user home) to be themed";
      example = "/Notes";
    };
  };

  config = mkIf cfg.enable {
    home.file = builtins.foldl' (
      acc: vault:
      acc
      // {
        "${vault}/.obsidian/appearance.json".text = builtins.toJSON {
          enabledCssSnippets = [ "whiskers" ];
        };

      }
    ) { } cfg.vaults;
  };
}
