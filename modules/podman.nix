{ config, pkgs, ... }:

{
  # Podman configuration
  home.file.".config/containers/registries.conf".text = ''
    [registries.search]
    registries = ['docker.io']
  '';

  home.file.".config/containers/policy.json".text = ''
    {
      "default": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    }
  '';

  # Enable dbus session for rootless podman
  home.sessionVariables = {
    DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/$(id -u)/bus";
  };
}
