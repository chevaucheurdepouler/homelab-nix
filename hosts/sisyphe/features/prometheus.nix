{ config, ... }:
{
  services.prometheus = {
    enable = true;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [
          "logind"
          "systemd"
        ];
        port = 9002;
      };
      borgmatic = {
        enable = true;
      };
      systemd = {
        enable = true;
      };
      sabnzbd = {
        enable = true;
        servers = [
          {
            "sisyphe" = {
              baseUrl = "http://nzb.sisyphe.normandy.rougebordeaux.xyz";
              apiKeyFile = "/run/secrets/sabnbzd_apikey";
            };
          }
        ];
      };
      redis = {
        enable = true;
      };
      postgres = {
        enable = true;
      };
      pihole = {
        enable = true;
        piholeHostname = "192.168.1.25";
      };
      php-fpm = {
        enable = true;
      };
      nextcloud = {
        enable = true;
        url = "https://cloud.rougebordeaux.xyz";
        tokenFile = "/run/secrets/nextcloudTokenFile";
      };
    };
    scrapeConfigs = [

      {
        job_name = "homelab-stats";
        static_configs = [
          {
            targets = [
              "localhost:${builtins.toString config.services.prometheus.exporters.node.port}"
              "192.168.1.197:9100"
            ];
          }
        ];
      }
    ];
  };
}
