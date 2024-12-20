# Programming language support
{ config, lib, ... }:

with lib;

let
  cfg = config.settings.languages;
in
{
  imports = [
    ./c-cpp.nix
    ./cmake.nix
    ./docker.nix
    ./go.nix
    ./java.nix
    ./latex.nix
    ./lua.nix
    ./make.nix
    ./markdown.nix
    ./nix.nix
    ./node.nix
    ./python.nix
    ./rust.nix
    ./shells.nix
    ./toml.nix
    ./typst.nix
    ./yaml.nix
  ];

  options.settings.languages.enable = mkEnableOption "Enable all programming language support";

  config.settings.languages = {
    c-cpp.enable = mkDefault cfg.enable;
    cmake.enable = mkDefault cfg.enable;
    docker.enable = mkDefault cfg.enable;
    go.enable = mkDefault cfg.enable;
    java.enable = mkDefault cfg.enable;
    latex.enable = mkDefault cfg.enable;
    lua.enable = mkDefault cfg.enable;
    make.enable = mkDefault cfg.enable;
    markdown.enable = mkDefault cfg.enable;
    nix.enable = mkDefault cfg.enable;
    node.enable = mkDefault cfg.enable;
    python.enable = mkDefault cfg.enable;
    rust.enable = mkDefault cfg.enable;
    shells.enable = mkDefault cfg.enable;
    toml.enable = mkDefault cfg.enable;
    typst.enable = mkDefault cfg.enable;
    yaml.enable = mkDefault cfg.enable;
  };
}
