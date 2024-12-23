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
    };
    scrapeConfigs = [
      {
        job_name = "synapse";
        scrape_interval = "15s";
        metrics_path = "/_synapse/metrics";
        static_configs = [ { targets = [ "localhost:9000" ]; } ];
      }
      {
        job_name = "homelab-stats";
        static_configs = [
          { targets = [ "localhost:${builtins.toString config.services.prometheus.exporters.node.port}" ]; }
        ];
      }
    ];

  };
}
