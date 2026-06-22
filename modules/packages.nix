{ config, pkgs, unstable, ... }:

{
  home.packages = with pkgs; [
    # Docker ecosystem
    docker
    docker-compose
    
    # CI/CD tools
    gh
    actionlint
    
    # Development tools
    unstable.just
    git
    curl
    jq
  ];
}
