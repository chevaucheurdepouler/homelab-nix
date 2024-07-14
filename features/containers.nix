{ ... }:

{
  # docker containers, for apps that aren't avaiable on Nix.  (yet)
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
      crafty-controller = {
        image = "registry.gitlab.com/crafty-controller/crafty-4:latest";
        ports = [
          "8443:8443"
          "8123:8123"
          "19132:19132/udp"
          "25500-25600:25500-25600"
        ];
        volumes = [
          "./docker/backups:/crafty/backups"
          "./docker/logs:/crafty/logs"
          "./docker/servers:/crafty/servers"
          "./docker/config:/crafty/app/config"
          "./docker/import:/crafty/import"
        ];
        environment = {
          "TZ" = "Europe/Paris";
        };
      };
    };
  };
}
