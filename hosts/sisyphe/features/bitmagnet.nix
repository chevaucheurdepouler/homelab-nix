{ pkgs, secrets, ... }:
{
  # sops.secrets.bitmagnet = { };
  services.bitmagnet = {
    enable = true;
    openFirewall = true;
    useLocalPostgresDB = true;
    settings = {
      # extra_config_files = "${secrets}/secrets/bitmagnet.env";
      http_server.local_address = "0.0.0.0";
      http_server.port = ":3333";
    };
  };
}
