{ config, ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      sonarrAnime = {
        image = "lscr.io/linuxserver/sonarr:latest";
        volumes = [
          "sonarr_data:/config"
          "/srv/Multimedia/DessinsAnime:/tv"
          "/srv/Multimedia/Torrents:/srv/Multimedia/Torrents"
        ];
        ports = [ "8999:8989" ];
        environment = {
          "PUID" = "1000";
          "GUID" = "1000";
          "TZ" = "Europe/Paris";
        };
      };

      bazarrAnime = {
        image = "lscr.io/linuxserver/bazarr:latest";
        volumes = [
          "bazarr_data:/config"
          "/srv/Multimedia/DessinsAnime:/tv"
        ];
        ports = [ "6777:6767" ];
        environment = {
          "PUID" = "1000";
          "GUID" = "1000";
          "TZ" = "Europe/Paris";
        };
      };
    };
  };
}
