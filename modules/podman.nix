{ config, pkgs, ... }:

{
  # Podman engine configuration
  home.file.".config/containers/containers.conf".text = ''
    [engine]
    cgroup_manager = "cgroupfs"
    events_logger = "file"

    [network]
    network_backend = "netavark"
  '';

  # Storage configuration for rootless podman
  home.file.".config/containers/storage.conf".text = ''
    [storage]
    driver = "overlay"

    [storage.options.overlay]
    mount_program = "${pkgs.fuse-overlayfs}/bin/fuse-overlayfs"
  '';

  # Container image registries
  home.file.".config/containers/registries.conf".text = ''
    [registries.search]
    registries = ['docker.io']
  '';

  # Container image signature policy
  home.file.".config/containers/policy.json".text = ''
    {
      "default": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    }
  '';
}
