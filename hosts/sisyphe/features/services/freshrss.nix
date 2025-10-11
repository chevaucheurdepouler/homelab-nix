{ config, lib, ... }:
with lib;

let
  cfg = config.freshrss;
in
{
  options = {
    freshrss.url = mkOption {
      type = types.str;
      default = "http://journal.rougebordeaux.xyz";
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
