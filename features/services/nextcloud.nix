{ config, ... }:
{
  sops.secrets.adminNextcloudPass = { };
  services.nextcloud = {

    enable = true;
    hostName = "cloud.hypervirtual.world";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = config.sops.secrets.adminNextcloudPass.path;
    };
  };
}
