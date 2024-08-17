{ pkgs, config, ... }:
{
  sops.secrets.photoprismAdmin = { };
  sops.secrets.photoprismPassword = { };

  environment.systemPackages = with pkgs; [
    photoprism
  ];

  services.photoprism = {
    enable = true;
    port = 2342;
    originalsPath = "/var/lib/private/photoprism/originals";
    settings = {
      PHOTOPRISM_ADMIN_USER = "admin";
      PHOTOPRISM_DEFAULT_LOCALE = "fr";
      PHOTOPRISM_DATABASE_DRIVER = "mysql";
      PHOTOPRISM_DATABASE_NAME = "photoprism";
      PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
      PHOTOPRISM_DATABASE_USER = "photoprism";
      PHOTOPRISM_SITE_URL = "http://photos.hypervirtual.world";
      PHOTOPRISM_SITE_TITLE = "hyperreal photoprism???";
    };
    passwordFile = config.sops.secrets.photoprismPassword.path;
  };
}
