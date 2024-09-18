# ZSH configuration
{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

let
  cfg = config.settings.shell;
in

{
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      dotDir = ".config/zsh";

      history = {
        append = true;
        share = true;
        extended = true;
        ignoreSpace = true;
        ignoreDups = true;
        ignoreAllDups = true;
        expireDuplicatesFirst = true;
      };

      sessionVariables = import ./environment.nix;
      shellAliases = import ./aliases.nix;

      initExtra = ''
        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

        # Search history settings
        autoload -U up-line-or-beginning-search
        autoload -U down-line-or-beginning-search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey "^[[A" up-line-or-beginning-search # Up
        bindkey "^[[B" down-line-or-beginning-search # Down

        # Cli tools shell integration
        eval "$(zoxide init --cmd cd zsh)"
        eval "$(fzf --zsh)"

        # Additional paths for top level shells
        if [[ $SHLVL -eq 1 ]]; then
          export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
          export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin"
        fi

        # Trim nix profile paths for subshells (remove leading paths not starting in `/nix/store`)
        if [[ $SHLVL -gt 1 ]]; then
          store_path=()
          new_path=()

          for entry in "''${path[@]}"; do
            [[ $entry == /nix/store* ]] && store_path+=("$entry") || new_path+=("$entry")
          done

          path=("''${store_path[@]}" "''${new_path[@]}")
        fi

        # Silence direnv logs (empty env var)
        export DIRENV_LOG_FORMAT=

        # Disable seahorse askpass
        unset SSH_ASKPASS
      '';

      # Extra plugins
      plugins = [
        {
          name = "zsh-autosuggestions";
          file = "fzf-tab.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "v1.1.2";
            sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
          };
        }
        {
          name = "transient-prompt";
          src = ../../../dotfiles/zsh;
          file = "transient-prompt.zsh";
        }
        {
          name = "ssh";
          src = ../../../dotfiles/zsh;
          file = "ssh.zsh";
        }
      ];
    };
  };
}
