{ config, pkgs, unstable, ... }:

{
  home.packages = with pkgs; [
    # Docker ecosystem
    docker
    docker-compose
    
    # CI/CD tools
    gh
    actionlint
    
    # Podman ecosystem
    podman
    podman-compose

    # DBus (required by podman)
    dbus

    # Development tools
    unstable.just
    git
    curl
    jq
  ];
}
