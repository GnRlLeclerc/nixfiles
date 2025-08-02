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
    just
    lazygit
    lazydocker
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
