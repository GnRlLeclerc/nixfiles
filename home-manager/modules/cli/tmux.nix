# Tmux configuration
{
  lib,
  pkgs,
  ...
}:

let
  # Custom tmux plugins
  tmux-sessionx = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-sessionx";
    version = "1.0";
    rtpFilePath = "sessionx.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "omerxx";
      repo = "tmux-sessionx";
      rev = "ecc926e7db7761bfbd798cd8f10043e4fb1b83ba";
      sha256 = "sha256-S/1mcmOrNKkzRDwMLGqnLUbvzUxcO1EcMdPwcipRQuE=";
    };
  };

  tmux-floax = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-floax";
    version = "1.0";
    rtpFilePath = "floax.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "omerxx";
      repo = "tmux-floax";
      rev = "dab0587c5994f3b061a597ac6d63a5c9964d2883";
      sha256 = "sha256-gp/l3SLmRHOwNV3glaMsEUEejdeMHW0CXmER4cRhYD4=";
    };
  };

  test = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "unstable-2024-05-15";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "697087f593dae0163e01becf483b192894e69e33";
      hash = "sha256-EHinWa6Zbpumu+ciwcMo6JIIvYFfWWEKH1lwfyZUNTo=";
    };

    # Apply custom patch to modify the theme directory (make it point to a local one)
    # TODO : see how to integrate this with stylix instead
    # postInstall = lib.optionalString withFlavours ''
    #   sed -i -e 's|done <"''${PLUGIN_DIR}/themes/catppuccin_''${theme}.tmuxtheme"|done <"${config.xdg.configHome}/tmux/themes/catppuccin_base16.tmuxtheme"|g' $target/catppuccin.tmux
    # '';

    meta = with lib; {
      homepage = "https://github.com/catppuccin/tmux";
      description = "Soothing pastel theme for Tmux!";
      license = licenses.mit;
      platforms = platforms.unix;
      maintainers = with maintainers; [ jnsgruk ];
    };
  };

in
{
  programs.tmux = {
    # Base settings
    prefix = "C-a";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 100000;
    mouse = true;
    keyMode = "vi";

    extraConfig = ''
      set-option -g default-terminal 'screen-256color'
      set -g detach-on-destroy off     # don't exit from tmux when closing a session
      set -g renumber-windows on       # renumber all windows when any window is closed
      set -g set-clipboard on          # use system clipboard
      set -g status-position top
      set -g default-terminal "''${TERM}"
      set -g pane-active-border-style 'fg=magenta,bg=default'
      set -g pane-border-style 'fg=brightblack,bg=default'
    '';

    plugins = with pkgs; [
      # tmuxPlugins.sensible (enabled by default)
      tmuxPlugins.yank
      tmuxPlugins.tmux-thumbs
      tmuxPlugins.tmux-fzf
      {
        plugin = tmuxPlugins.fzf-tmux-url;
        extraConfig = ''
          set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
          set -g @fzf-url-history-limit '2000'
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = test;
        extraConfig = ''
          set -g @catppuccin_flavour "mocha"
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules_right "directory date_time"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-auto-accept 'off'
          set -g @sessionx-custom-paths '/home/thibaut/Projects/dotfiles'
          set -g @sessionx-bind 'o'
          set -g @sessionx-x-path '~/Projects/dotfiles'
          set -g @sessionx-window-height '85%'
          set -g @sessionx-window-width '75%'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-custom-paths-subdirectories 'false'
          set -g @sessionx-filter-current 'false'
        '';
      }
      {
        plugin = tmux-floax;
        extraConfig = ''
          set -g @floax-width '80%'
          set -g @floax-height '80%'
          set -g @floax-border-color 'magenta'
          set -g @floax-text-color 'blue'
          set -g @floax-bind 'p'
          set -g @floax-change-path 'false'
        '';
      }
    ];
  };
}
