# Nix cache sources
{ lib, ... }:
{
  nix.settings = {
    substituters = lib.mkAfter [
      "https://cuda-maintainers.cachix.org" # cudaSupport sources
    ];

    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
}
