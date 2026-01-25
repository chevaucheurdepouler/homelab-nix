{ pkgs, secrets, ... }:
{
  sops.secrets.bitmagnet = { };
  services.bitmagnet = {
    enable = true;
    openFirewall = true;
    useLocalPostgresDB = true;
    settings = {
      # extra_config_files = "${secrets}/secrets/bitmagnet.env";
    };
  };
}
