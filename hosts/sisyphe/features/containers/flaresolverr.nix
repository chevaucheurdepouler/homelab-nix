{ config, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      flaresolverr = {
        ports = [ "8191:8191" ];
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
        environment = {
          "LOG_LEVEL" = "info";
        };
      };
    };
  };
}
