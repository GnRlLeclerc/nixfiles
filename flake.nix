{
  description = "GnRl_Leclerc's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:the-argus/spicetify-nix";

    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      flatpaks,
      home-manager,
      nixos-hardware,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      overlays = import ./overlays;

      # Supported systems
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

    in
    {
      # Nixos configurations with home-manager as a module
      nixosConfigurations = {
        main-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./nixos/devices/main-laptop.nix
            nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-nvidia
            overlays

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.thibaut = import ./home-manager/users/thibaut.nix;
            }
          ];
        };
      };

      # Standalone home-manager profiles for all platforms
      packages = forAllSystems (system: {
        homeConfigurations = {
          # My own user
          thibaut = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            extraSpecialArgs = {
              inherit inputs outputs system;
            };

            modules = [
              overlays
              ./home-manager/users/thibaut.nix
            ];
          };
        };
      });

      # Nix files formatter for this repository
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
