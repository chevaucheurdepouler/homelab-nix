{ config, lib, ... }:
with lib;

let
  cfg = config.freshrss;
in
{
  options = {
    freshrss.url = mkOption {
      type = types.str;
      default = "http://192.168.1.177:3005";
    };
  };

  config = {
    sops.secrets = {
      freshrss_username = {
        sopsFile = ../secrets/freshrss.json;
      };
      freshrss_password = {
        sopsFile = ../secrets/freshrss.json;
      };
    };

    services.freshrss = {
      enable = true;
      language = "fr";
      defaultUser = config.sops.secrets.freshrss_username;
      baseUrl = cfg.url;
      passwordFile = config.sops.secrets.freshrss_password.path;
      database = {
        type = "sqlite";
      };
    };
  };
}
