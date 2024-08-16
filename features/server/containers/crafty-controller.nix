{ config, lib, ... }:
with lib;

let
  cfg = config.docker;
in
{
  options = {
    docker.minecraft.path = mkOption {
      type = types.str;
      default = "/srv/Minecraft";
    };
  };
  config = {

    # docker containers, for apps that aren't avaiable on Nix.  (yet)
    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
        #TODO: move to Nix crafty controller bundle
        crafty-controller = {
          image = "registry.gitlab.com/crafty-controller/crafty-4:latest";
          ports = [
            "8443:8443"
            "8123:8123"
            "19132:19132/udp"
            "25500-25600:25500-25600"
          ];
          volumes = [
            "${cfg.minecraft.path}/docker/backups:/crafty/backups"
            "${cfg.minecraft.path}/docker/logs:/crafty/logs"
            "${cfg.minecraft.path}/docker/servers:/crafty/servers"
            "${cfg.minecraft.path}/docker/config:/crafty/app/config"
            "${cfg.minecraft.path}/docker/import:/crafty/import"
          ];
          environment = {
            "TZ" = "Europe/Paris";
          };
        };
      };
    };
  };
}
