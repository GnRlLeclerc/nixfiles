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

        # Load micromamba if available
        if which micromamba &> /dev/null; then
          export MAMBA_EXE='${pkgs.micromamba}/bin/micromamba';
          export MAMBA_ROOT_PREFIX='/home/thibaut/micromamba';

          __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
          if [ $? -eq 0 ]; then
              eval "$__mamba_setup"
          else
              alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
          fi
          unset __mamba_setup

          # Disable prompt change on conda activation
          micromamba config set changeps1 False

          alias conda='micromamba'
          alias mamba='micromamba'

          alias default-env-create='micromamba env create -f ${../../../dotfiles/conda/datascience.yml}'
          alias default-env-update='micromamba env update --name datascience -f ${../../../dotfiles/conda/datascience.yml}'
          alias default-env-activate='micromamba activate ~/micromamba/envs/datascience'
        fi

        # Load pyenv if available
        if which pyenv &> /dev/null; then
          export PYENV_ROOT="$HOME/.pyenv"
          [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
          eval "$(pyenv init - zsh)"
        fi
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
