{
  description = "Multi-machine Home Manager config with flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, ... }: let
    system  = "x86_64-linux";
    pkgs     = import nixpkgs { inherit system; config.allowUnfree = true; };
    unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
  in {
    homeConfigurations = {

      # Linux system (Azure)
      azureuser = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Pass unstable into modules
        extraSpecialArgs = { inherit unstable; };

        modules = [
          ./home.nix
          ./modules/packages.nix
          {
            home.username = "azureuser";
            home.homeDirectory = "/home/azureuser";
          }
        ];
      };

      # Macbook (M Series)
      chamalgomes = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        modules = [ ./home.nix ];
        home.username = "chamalgomes";
        home.homeDirectory = "/Users/chamalgomes";
      };
    };
  };
}

