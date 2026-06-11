{ config, pkgs, just, ... }:

let
  justPackage = just.packages.${pkgs.system}.default;
in
{
  home.packages = with pkgs; [
    # Docker ecosystem
    docker
    docker-compose
    
    # CI/CD tools
    gh
    actionlint
    
    # Development tools
    justPackage
    git
    curl
    jq
  ];
}
