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
      # borgmatic = {
      #   enable = true;
      # };
      systemd = {
        enable = true;
      };

      # TODO: set up all services config
      # redis = {
      #   enable = true;
      # };
      # postgres = {
      #   enable = true;
      # };
      # pihole = {
      #   enable = true;
      #   piholeHostname = "pi.hole";
      # };
      # exportarr-radarr = {
      #   enable = true;
      #   apiKeyFile = "/run/secrets/radarr";
      # };
      # exportarr-sonarr = {
      #   enable = true;
      #   apiKeyFile = "/run/secrets/sonarr";
      # };
      # exportarr-prowlarr = {
      #   enable = true;
      #   apiKeyFile = "/run/secrets/prowlarr";
      # };
      # exportarr-bazarr = {
      #   enable = true;
      #   apiKeyFile = "/run/secrets/bazarr";
      # };
      ping.enable = true;
      domain.enable = true;
      # tailscale.enable = true;
      /*
        TODO: need to fix secrets before
        nextcloud = {
          enable = true;
          url = "https://cloud.rougebordeaux.xyz";
          tokenFile = "/run/secrets/nextcloudTokenFile";
        };
      */
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
