{
  description = "GnRl_Leclerc's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nur.url = "github:nix-community/nur";
  };

  outputs =
    {
      self,
      home-manager,
      nixos-hardware,
      nixpkgs,
      ...
    }@inputs:
    let
      # Supported systems
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
      overlays = import ./overlays;

      inheritArgs = {
        inherit
          forAllSystems
          home-manager
          inputs
          nixos-hardware
          nixpkgs
          overlays
          ;
      };

      nixosConfigurations = import ./nixos/nixos-configurations.nix inheritArgs;
      homeConfigurations = import ./home-manager/home-configurations.nix inheritArgs;
      devShells = import ./devshells inheritArgs;
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    in
    {
      inherit
        nixosConfigurations
        devShells
        formatter
        homeConfigurations
        ;
    };
}
