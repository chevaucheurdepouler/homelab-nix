{ pkgs, config, ... }:
{
  sops.secrets.adminPassword = {
    sopsFile = ../secrets/photoprism.env;
    format = "dotenv";
  };

  services.photoprism = {
    enable = true;
    port = 2342;
    originalsPath = "/var/lib/private/photoprism/originals";
    settings = {
      PHOTOPRISM_ADMIN_USER = "lospussyadminos";
      PHOTOPRISM_ADMIN_PASSWORD = config.sops.secrets.adminPassword;
      PHOTOPRISM_DEFAULT_LOCALE = "fr";
      PHOTOPRISM_DATABASE_DRIVER = "mysql";
      PHOTOPRISM_DATABASE_NAME = "photoprism";
      PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
      PHOTOPRISM_DATABASE_USER = "photoprism";
      PHOTOPRISM_SITE_URL = "http://192.168.1.177:2342";
      PHOTOPRISM_SITE_TITLE = "hyperreal photoprism???";
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureDatabases = [ "photoprism" ];
    ensureUsers = [
      {
        name = "photoprism";
        ensurePermissions = {
          "photoprism.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
