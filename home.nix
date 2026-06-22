{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/options.nix
    ./modules/packages.nix
    ./modules/git.nix
    ./modules/bash.nix
    ./modules/vim.nix
    ./modules/zsh.nix
    ./modules/docker.nix
    ./modules/podman.nix
  ];

  my.home.trustedGitDirs = [
    "/home/azureuser/repos/*"
  ];

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Required for migration tracking
  home.stateVersion = "23.11";
}
