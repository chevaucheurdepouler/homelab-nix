{ config, lib, ... }:
with lib;

let
  cfg = config.downloads.transmission;
in
{
  options = {
    downloads.transmission = {
      directory = mkOption {
        type = lib.types.str;
        default = "/srv/Multimedia";
      };
    };
  };

  config = {
    sops.secrets.transmission = {
      sopsFile = ../../../secrets/transmission.json;
      path = "/var/lib/secrets/transmission/settings.json";
    };

    # torrenting apps
    services.transmission = {
      enable = true;
      openFirewall = true;
      openRPCPort = true;
      credentialsFile = config.sops.secrets.transmission.path;
      settings = {
        rpc-bind-address = "0.0.0.0";
        rpc-whitelist-enabled = false;
        rpc-authentication-required = true;
        download-dir = "${cfg.directory}/Torrents";
        ratio-limit-enabled = true;
      };
    };
  };
}
