# Flavours home-manager module
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.flavours;

  boolToString = b: if b then "true" else "false";

  # Items configuration submodule
  itemsSubmodule = types.submodule (
    { config, ... }:
    {
      options = {
        file = mkOption {
          type = types.str;
          description = "The file path where the template will be written.";
        };

        template = mkOption {
          type = types.str;
          description = "The template file that will be used to generate the configuration.";
        };

        subtemplate = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "The template variant to use.";
        };

        rewrite = mkOption {
          type = types.nullOr types.bool;
          default = false;
          description = "Whether the configuration file should be rewritten.";
        };

        hook = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Optional script or hook to run after writing the file.";
        };
      };
    }
  );

in
{
  options.programs.flavours = {

    enable = mkEnableOption "Enable dynamic theming with flavours";

    settings = mkOption {
      type = types.listOf itemsSubmodule;
      default = [ ];
      description = "Flavour settings.";
      example = literalExpression ''
        [
          {
            file = "~/.config/nvim/lua/base16_colors.lua";
            template = "luakit";
            subtemplate = "colors";
            rewrite = true;
          }
          {
            file = "~/.config/helix/themes/base16.toml";
            template = "helix";
            rewrite = true;
          }
        ]
      '';
    };
  };

  config = mkIf cfg.enable {

    # Install flavours
    home.packages = with pkgs; [ flavours ];

    # Write the configuration file
    xdg.configFile."flavours/config.toml".text = builtins.concatStringsSep "\n\n" (
      map (fileConfig: ''
        [[items]]
        file = "${fileConfig.file}"
        template = "${fileConfig.template}"
        ${optionalString (fileConfig.subtemplate != null) ''subtemplate = "${fileConfig.subtemplate}"''}
        ${optionalString (fileConfig.rewrite != null) ''rewrite = ${boolToString fileConfig.rewrite}''}
        ${optionalString (fileConfig.hook != null) ''hook: "${fileConfig.hook}"''}
      '') cfg.settings
    );
  };
}
