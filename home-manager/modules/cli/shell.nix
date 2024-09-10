# ZSH configuration
{ pkgs, ... }:
{
  programs.zsh = {
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

    sessionVariables = {
      # Allow for mouse scrolling in git-delta
      DELTA_PAGER = "less --mouse";

      # Remote nvim for synctex
      NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";

      # Silence Poetry
      PYTHON_KEYRING_BACKEND = "keyring.backends.fail.Keyring";

      # Android emulator (enable starting expo app directly in emulator)
      ANDROID_HOME = "$HOME/Android/Sdk";

      GOPATH = "$HOME/go";

      # Bat & delta color theme
      BAT_THEME = "base16";

    };

    shellAliases = {
      cargo-update = "cargo install-update -a"; # Update all programs installed via "cargo install"
      cat = "bat --paging=never --style=plain"; # Bat without paging
      du = "dust";
      grep = "rg";
      less = "bat --paging=always --style=plain"; # Bat with always paging
      neofetch = "fastfetch";
      ps = "procs";
      c = "clear";
      icat = "kitten icat";
      lolcat = "dotacat";

      # Eza aliases
      l = "ls";
      ls = "eza -g --icons --header --group-directories-first";
      la = "eza -ag --icons --header --group-directories-first";
      lr = "eza -lTg -L 2 --icons --header --group-directories-first";
      lR = "eza -lTg --icons --header --group-directories-first";
      lu = "eza -l --total-size --no-time --no-user --no-permissions --sort size --reverse";

      # Remove all local branches that do not have remotes
      git-remove-local = "git fetch -p ; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d";
    };

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

      # Paths
      export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
      export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin"
    '';

    # Extra plugins
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
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
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ../../dotfiles/zsh;
        file = "p10k.zsh";
      }
      {
        name = "ssh";
        src = ../../dotfiles/zsh;
        file = "ssh.zsh";
      }
    ];
  };

  # Useful shell packages
  home.packages = with pkgs; [
    # Basic cli
    gawk
    gnused
    jq

    # Fancy cli
    bat
    delta
    dotacat
    dust
    eza
    fastfetch
    fd
    fzf
    lazygit
    lazydocker
    procs
    ripgrep
    tldr
    zoxide
  ];
}
