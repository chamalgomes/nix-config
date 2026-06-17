{
  description = "Multi-machine Home Manager config with flakes";

  inputs = {
    # Pinned from flake.lock:
    #   rev: b134951a4c9f3c995fd7be05f3243f8ecd65d798
    #   narHash: sha256-OnSAY7XDSx7CtDoqNh8jwVwh4xNL/2HaJxGjryLWzX8=
    nixpkgs.url = "github:NixOS/nixpkgs/b134951a4c9f3c995fd7be05f3243f8ecd65d798";
    # Pinned from flake.lock:
    #   rev: a799d3e3886da994fa307f817a6bc705ae538eeb
    #   narHash: sha256-3av0pIjlOWQ6rDbNOmpUSvbNnJkGORQKKjb4LtCZsIY=
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/a799d3e3886da994fa307f817a6bc705ae538eeb";
    # Pinned from flake.lock:
    #   rev: 2f23fa308a7c067e52dfcc30a0758f47043ec176
    #   narHash: sha256-Vl+WVTJwutXkimwGprnEtXc/s/s8sMuXzqXaspIGlwM=
    home-manager.url = "github:nix-community/home-manager/2f23fa308a7c067e52dfcc30a0758f47043ec176";
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
