# Import all cli application configurations (without activating them)
# Set `options.settings.cli` to true to activate all cli applications
{ lib, config, ... }:

with lib;

let
  cfg = config.settings.cli;

in
{
  imports = [
    ./neovim.nix
  ];

  options.settings.cli.enable = mkEnableOption "Enable all cli applications";

  config = {
    programs.neovim.enable = mkDefault cfg.enable;
  };
}
