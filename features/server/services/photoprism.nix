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
    originalsPath = "/srv/cloud/photoprism/originals";
    importPath = "/srv/cloud/photoprism/imports";
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

  systemd.tmpfiles.rules = [
    "d /srv/cloud/photoprism/originals 0755 photoprism photoprism"
    "d /srv/cloud/photoprism/imports 0755 photoprism photoprism"
  ];
}
