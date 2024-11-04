# Nix cache sources
{ lib, ... }:
{
  nix.settings = {
    substituters = lib.mkAfter [
      "https://cuda-maintainers.cachix.org" # cudaSupport sources
      "https://nix-community.cachix.org" # additional nix-community sources
    ];

    trusted-public-keys = lib.mkAfter [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    max-jobs = 12; # Not 16, to avoid OOM errors
  };
}
