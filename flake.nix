{
  description = "GnRl_Leclerc's NixOS configuration";

  inputs = {
    # Use unstable as the default
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nur.url = "github:nix-community/nur";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      home-manager,
      nixos-hardware,
      nixpkgs,
      nixpkgs-stable,
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
      overlays = import ./overlays { inherit inputs; };

      inheritArgs = {
        inherit
          forAllSystems
          home-manager
          inputs
          nixos-hardware
          nixpkgs
          nixpkgs-stable
          overlays
          ;
      };

      nixosConfigurations = import ./nixos/nixos-configurations.nix inheritArgs;
      homeConfigurations = import ./home-manager/home-configurations.nix inheritArgs;
      devShells = import ./devshells inheritArgs;
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      # Setup pour explorer le build d'un package
      # TODO : proper isolated module ?
      packages =
        let
          pkgs = import nixpkgs {
            config = {
              allowUnfree = true;
            };
            system = "x86_64-linux";
            overlays = overlays.stable;
          };

        in
        {
          x86_64-linux.enchant2 = pkgs.enchant2;
        };
    in
    {
      inherit
        nixosConfigurations
        devShells
        formatter
        homeConfigurations
        packages
        ;
    };
}
