# Shell aliases
let
  # The shell command to run after entering a nix develop shell
  nixDevelopShell = "zsh";
  mkNixDevelopAlias = shellName: "nix develop ${../../../..}#${shellName} -c ${nixDevelopShell}";
in
{
  cargo-update = "cargo install-update -a"; # Update all programs installed via "cargo install"
  cat = "bat --paging=never --style=plain"; # Bat without paging
  du = "dust";
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

  # Global nix shell aliases
  shell-python310 = mkNixDevelopAlias "python310";
  shell-python311 = mkNixDevelopAlias "python311";
  shell-python312 = mkNixDevelopAlias "python312";
  shell-node20 = mkNixDevelopAlias "node20";
  shell-node22 = mkNixDevelopAlias "node22";
  shell-uv = mkNixDevelopAlias "uv";
}
