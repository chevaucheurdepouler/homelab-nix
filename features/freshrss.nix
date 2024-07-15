{ config, lib, ... }:
{
  sops.secrets = {
    freshrss_username = {
      path = ../secrets/freshrss.json;
      format = "json";
    };
    freshrss_password = {
      path = ../secrets/freshrss.json;
      format = "json";
    };
  };

  services.freshrss = {
    enable = true;
    language = "fr";
    defaultUser = config.sops.freshrss_username;
    passwordFile = config.sops.freshrss_password.path;
    database = {
      type = "sqlite";
    };
  };
}
