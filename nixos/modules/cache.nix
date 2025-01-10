# Nix cache sources
{ lib, ... }:
{
  nix.settings = {
    substituters = lib.mkAfter [
      "https://nix-community.cachix.org" # additional nix-community sources
    ];

    trusted-public-keys = lib.mkAfter [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
