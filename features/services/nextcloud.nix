{ config, ... }:
{
  services.nextcloud = {
    enable = true;
    hostName = "cloud.hypervirtual.world";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
    };
  };
}
