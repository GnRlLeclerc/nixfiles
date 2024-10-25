# Shell starship configuration
{ lib, config, ... }:

with lib;

let
  cfg = config.settings.shell;
in
{
  config = mkIf cfg.enable {

    programs.starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$cmd_duration"
          "$line_break"
          "$python"
          "$conda"
          "$character"
        ];

        right_format = lib.concatStrings [
          "$direnv"
          "$shlvl"
        ];

        directory = {
          style = "blue";
          read_only = "  ";
        };

        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](green)";
        };

        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };

        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "";
          untracked = "";
          modified = "";
          staged = "";
          renamed = "";
          deleted = "";
          stashed = "≡";
        };

        git_state = {
          format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
          style = "bright-black";
        };

        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };

        python = {
          format = "[$virtualenv]($style) ";
          style = "bright-black";
        };

        conda = {
          format = "[\\(conda\\) $environment]($style) ";
          style = "bright-black";
        };

        shlvl = {
          disabled = false;
          threshold = 2;
          symbol = " ";
        };

        direnv = {
          symbol = "(direnv) ";
          style = "bold yellow";
          format = "[$symbol$loaded$allowed]($style) ";
          disabled = false;
          allowed_msg = " ";
          not_allowed_msg = " ";
          loaded_msg = " ";
          unloaded_msg = " ";
        };
      };
    };

    # Transient prompt starship settings
    xdg.configFile."starship-transient.toml".text = ''
      format = "$character"

      [character]
      error_symbol = "[❯](red)"
      success_symbol = "[❯](purple)"
      vimcmd_symbol = "[❮](green)"
    '';
  };
}
