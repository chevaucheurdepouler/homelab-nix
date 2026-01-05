{ ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      hetzner-storage-exporter = {
        image = "ghcr.io/crstian19/prometheus-storagebox-exporter:latest";
        ports = [ "9509:9509" ];
        volumes = [
          "/run/secrets/hetzner-token:/run/secrets/hetzner-token:ro"
        ];
        environment = {
          "TZ" = "Europe/Paris";
        };
      };
    };
  };
}
