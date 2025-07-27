# Import all cli application configurations (without activating them)
# Set `options.settings.cli` to true to activate all cli applications
{ lib, config, ... }:

with lib;

let
  cfg = config.settings.cli;

in
{
  imports = [
    ./fastfetch.nix
    ./helix.nix
    ./shell
  ];

  options.settings.cli.enable = mkEnableOption "Enable all cli applications";

  config = {
    programs.direnv.enable = mkDefault cfg.enable;
    programs.direnv.nix-direnv.enable = mkDefault cfg.enable;
    programs.helix.enable = mkDefault cfg.enable;
    settings.shell.enable = mkDefault cfg.enable;
    programs.fastfetch.enable = mkDefault cfg.enable;
  };
}
