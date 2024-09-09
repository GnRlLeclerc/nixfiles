# Programming language support
{ config, lib, ... }:

with lib;

let
  cfg = config.settings.languages;
in
{
  imports = [
    ./go.nix
    ./lua.nix
    ./nix.nix
    ./rust.nix
    ./toml.nix
    ./yaml.nix
  ];

  options.settings.languages.enable = mkEnableOption "Enable all programming language support";

  config.settings.languages = {
    go.enable = mkDefault cfg.enable;
    lua.enable = mkDefault cfg.enable;
    nix.enable = mkDefault cfg.enable;
    rust.enable = mkDefault cfg.enable;
    toml.enable = mkDefault cfg.enable;
    yaml.enable = mkDefault cfg.enable;
  };
}
