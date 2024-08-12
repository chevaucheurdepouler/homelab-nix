{ config, ... }:

{

  sops.secrets.piholeHostname = {};
  sops.secrets.piholePassword = {};

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      pihole-exporter = {
        image = "ekofr/pihole-exporter:latest";
        ports = [ "9617:9617" ];
        environment = {
          "PIHOLE_HOSTNAME" = config.sops.secrets.piholeHostname;
          "PIHOLE_PASSWORD" = config.sops.secrets.piholePassword;
        };
      };
    };
  };
}
