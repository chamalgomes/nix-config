{ config, pkgs, unstable, ... }:

{
  home.packages = with pkgs; [
    # Stable nixpkgs (nixpkgs) pinned at:
    #   b134951a4c9f3c995fd7be05f3243f8ecd65d798

    # Docker ecosystem (source: nixpkgs stable @ b134951a4c9f3c995fd7be05f3243f8ecd65d798)
    docker
    docker-compose
    
    # CI/CD tools (source: nixpkgs stable @ b134951a4c9f3c995fd7be05f3243f8ecd65d798)
    gh
    actionlint
    
    # Development tools
    # source: nixpkgs-unstable @ a799d3e3886da994fa307f817a6bc705ae538eeb
    unstable.just
    # source: nixpkgs stable @ b134951a4c9f3c995fd7be05f3243f8ecd65d798
    git
    curl
    jq
    terraform
  ];
}
