# Useful shell packages
{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # Basic cli
    gawk
    gnused
    jq
    bind
    tokei
    imagemagick
    socat

    # Fancy cli
    bat
    bluetui
    # cava  # BUG: broken
    cmatrix
    delta
    dotacat
    dust
    eza
    fastfetch
    fd
    fish
    fzf
    jujutsu
    just
    lazydocker
    lazygit
    lazyjj
    nix-diff
    nix-output-monitor
    nvtopPackages.full
    procs
    ripgrep
    starship
    stow
    tldr
    zellij
    zoxide

    # Caching
    cachix

    # Dynamic theming
    catppuccin-whiskers
  ];
}
