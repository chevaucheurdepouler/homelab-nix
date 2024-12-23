{ ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      freshrss = {
        image = "lscr.io/linuxserver/freshrss:latest";
        volumes = [ "/srv/freshrss/config:/config" ];
        ports = [ "8888:80" ];
        environment = {
          "PUID" = "1000";
          "GUID" = "1000";
          "TZ" = "Europe/Paris";
        };
      };
    };
  };
}
