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
    defaultUser = builtins.toString config.sops.secrets.freshrss_username;
    baseUrl = "http://localhost:3005";
    passwordFile = "/run/secrets/freshrss_password";
    database = {
      type = "sqlite";
    };
  };
}
