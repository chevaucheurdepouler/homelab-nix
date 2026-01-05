{ config, ... }:

{
  sops.secrets.postgres_password = { };
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      cloudreve = {
        ports = [
          "5212:5212"
          "6888:6888"
          "6888:6888/udp"
        ];
        volumes = [ "/srv/cloudreve:/cloudreve/data" ];
        image = "cloudreve/cloudreve:latest";
        environment = {
          "CR_CONF_DATABASE.Type" = "postgres";
        };
      };
    };
  };
}
