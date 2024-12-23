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
      freshrss_username = { };
      freshrss_password = { };
    };

    services.freshrss = {
      enable = true;
      language = "fr";
      defaultUser = "";
      baseUrl = cfg.url;
      passwordFile = config.sops.secrets.freshrss_password.path;
      database = {
        type = "sqlite";
      };
    };
  };
}
