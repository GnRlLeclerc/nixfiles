# Import all cli application configurations (without activating them)
# Set `options.settings.cli` to true to activate all cli applications
{ lib, config, ... }:

with lib;

let
  cfg = config.settings.cli;

in
{
  imports = [
    ./helix.nix
    ./neovim.nix
    ./shell.nix
    ./tmux.nix
  ];

  options.settings.cli.enable = mkEnableOption "Enable all cli applications";

  config = {
    programs.helix.enable = mkDefault cfg.enable;
    programs.neovim.enable = mkDefault cfg.enable;
    programs.zsh.enable = mkDefault cfg.enable;
    programs.tmux.enable = mkDefault cfg.enable;
  };
}
