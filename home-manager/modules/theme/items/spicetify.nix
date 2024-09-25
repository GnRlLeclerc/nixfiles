# Spicetify flavours configuration
{ config, lib, ... }:

with lib;

let
  cfg = config.programs.flavours.spicetify;
in
{
  options.programs.flavours.spicetify = mkEnableOption "Enable spicetify theming by flavours";

  config.programs = mkIf cfg {

    flavours.settings = mkIf cfg [
      {
        file = "${config.xdg.configHome}/spicetify/Themes/base16/color.ini";
        template = "spicetify";
        rewrite = true;
        # BUG: spicetify not available in cli
        # hook = "spicetify refresh";
      }
    ];

    # BUG : ça sera même pas possible, vu qu'une app electron ne peut rien watch...
    # TODO : voir comment brancher spicetify proprement
    # La seule solution serait de coder une extension, comme on a fait pour vscode, firefox...
    # Voir https://github.com/spicetify/cli/blob/main/Extensions/fullAppDisplay.js
    # On peut facilement faire ça, et le mélanger au thème sleek : https://github.com/spicetify/spicetify-themes/blob/master/Sleek/user.css
    # et regarder mon template flavours pour voir comment j'insérais les couleurs.

    # Pour rajouter l'extension dans la liste nix :
    # 1. Voir l'implémentation du flake pour voir où vont les déclarations de thèmes
    # 2. Voir comment reload ça
  };
}
