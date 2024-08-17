{ config, ... }:
{
  imports = [
    "${
      fetchTarball {
        url = "https://github.com/onny/nixos-nextcloud-testumgebung/archive/fa6f062830b4bc3cedb9694c1dbf01d5fdf775ac.tar.gz";
        sha256 = "0gzd0276b8da3ykapgqks2zhsqdv4jjvbv97dsxg0hgrhb74z0fs";
      }
    }/nextcloud-extras.nix"
    ./nextcloud-network.nix
  ]; # adding caddy support

  sops.secrets.adminNextcloudPass = {
    owner = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    hostName = "cloud.hypervirtual.world";
    database.createLocally = true;
    webserver = "caddy";
    configureRedis = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = config.sops.secrets.adminNextcloudPass.path;
    };
    settings.enabledPreviewProviders = [
      "OC\\Preview\\BMP"
      "OC\\Preview\\GIF"
      "OC\\Preview\\JPEG"
      "OC\\Preview\\Krita"
      "OC\\Preview\\MarkDown"
      "OC\\Preview\\MP3"
      "OC\\Preview\\OpenDocument"
      "OC\\Preview\\PNG"
      "OC\\Preview\\TXT"
      "OC\\Preview\\XBitmap"
      "OC\\Preview\\HEIC"
    ];

    settings.trustedDomains = [ "cloud.hypervirtual.world" ];
    settings.overwriteprotocol = "https";
    settings.log_type = "file";
    settings.default_phone_region = "FR";
    phpOptions."opcache.interned_strings_buffer" = "23";

  };
}
