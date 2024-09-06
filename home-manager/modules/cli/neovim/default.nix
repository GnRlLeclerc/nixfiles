# Neovim configuration
{ inputs, system, ... }:

let
  darwinSystems = [
    "aarch64-darwin"
    "x86_64-darwin"
  ];
  module = if builtins.elem system darwinSystems then "nixDarwinModules" else "homeManagerModules";
in
{

  imports = [
    inputs.nixvim."${module}".nixvim

    ./auto-cmd.nix
    ./keymaps.nix
    ./vim-options.nix

    ./plugins/editor
  ];

}
