{ config, pkgs, ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      sonarrAnime = {
        image = "mrusse08/soularr:latest";
        volumes = [
          "/srv/media/slskd_downloads:/downloads"
          "/srv/Multimedia/soularr-config:/data"
        ];
        environment = {
          "PUID" = "1000";
          "GUID" = "1000";
          "TZ" = "Europe/Paris";
          "SCRIPT_INTERVAL" = "300";
        };
      };
    };
  };
}
