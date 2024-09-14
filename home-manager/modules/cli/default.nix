# Import all cli application configurations (without activating them)
# Set `options.settings.cli` to true to activate all cli applications
{ lib, config, ... }:

with lib;

let
  cfg = config.settings.cli;

in
{
  imports = [
    ./direnv.nix
    ./helix.nix
    ./neovim.nix
    ./shell
    ./tmux.nix
  ];

  options.settings.cli.enable = mkEnableOption "Enable all cli applications";

  config = {
    programs.direnv.enable = mkDefault cfg.enable;
    programs.helix.enable = mkDefault cfg.enable;
    programs.neovim.enable = mkDefault cfg.enable;
    settings.shell.enable = mkDefault cfg.enable;
    programs.tmux.enable = mkDefault cfg.enable;
  };
}
