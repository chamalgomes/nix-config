{ ... }:

{
  # Central package/source manifest for auditability.
  #
  # Stable input:
  #   input: nixpkgs
  #   rev: b134951a4c9f3c995fd7be05f3243f8ecd65d798
  #   narHash: sha256-OnSAY7XDSx7CtDoqNh8jwVwh4xNL/2HaJxGjryLWzX8=
  #   packages:
  #     - docker
  #     - docker-compose
  #     - gh
  #     - actionlint
  #     - git
  #     - curl
  #     - jq
  #     - terraform
  #     - vimPlugins.vim-just
  #     - git (bash prompt dependency via pkgs.git path)
  #
  # Unstable input:
  #   input: nixpkgs-unstable
  #   rev: a799d3e3886da994fa307f817a6bc705ae538eeb
  #   narHash: sha256-3av0pIjlOWQ6rDbNOmpUSvbNnJkGORQKKjb4LtCZsIY=
  #   packages:
  #     - just
  #
  # Related pinned input:
  #   input: home-manager
  #   rev: 2f23fa308a7c067e52dfcc30a0758f47043ec176
  #   narHash: sha256-Vl+WVTJwutXkimwGprnEtXc/s/s8sMuXzqXaspIGlwM=
}
