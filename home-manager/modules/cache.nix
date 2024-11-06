# Nix cache sources
# NOTE: the home-manager configuration must explicitely include https://cache.nixos.org/ !
# Contrary to nixos configurations, it is not included by default,
# and the home-manager configuration in ~/.conf/nix might take precedence over /etc/nix/nix.conf!
_: {
  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://cuda-maintainers.cachix.org" # cudaSupport sources
      "https://nix-community.cachix.org" # additional nix-community sources
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
