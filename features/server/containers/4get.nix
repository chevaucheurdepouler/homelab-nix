{config, ...}:
{
    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
       fourget = {
        image = "luuul/4get:latest";
        environment = {
          "FOURGET_PROTO" = "http";
          "FOURGET_SERVER_NAME" = "192.168.1.177:6942";
        };
        ports = ["6942:80"];
      }; 
      };
    };
}
