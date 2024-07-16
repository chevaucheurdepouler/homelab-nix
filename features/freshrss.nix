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
    defaultUser = config.sops.secrets.freshrss_username;
    baseUrl = "http://localhost:3005";
    passwordFile = builtins.toPath config.sops.secrets.freshrss_password.path;
    database = {
      type = "sqlite";
    };
  };
}
