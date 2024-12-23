{
  config,
  secrets,
  lib,
  pkgs,
  ...
}:
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
      sopsFile = "${secrets}/secrets/transmission.json";
      path = "/var/lib/secrets/transmission/settings.json";
    };

    # torrenting apps
    services.transmission = {
      enable = true;
      openFirewall = true;
      openRPCPort = true;
      credentialsFile = config.sops.secrets.transmission.path;
      webHome = pkgs.flood-for-transmission;
      settings = {
        rpc-bind-address = "0.0.0.0";
        rpc-whitelist-enabled = false;
        rpc-authentication-required = true;
        download-dir = "${cfg.directory}/Torrents";
        ratio-limit-enabled = true;
        alt-speed-time-enabled = true;
        alt-speed-time-begin = "480";
        alt-speed-time-end = "1320";
      };
    };

    services.caddy.virtualHosts."http://transmission.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :9091
      '';
  };
}
