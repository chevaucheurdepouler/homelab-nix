{ config, lib, ... }:
{
  sops.secrets = {
    path = ../secrets/freshrss.json;
    freshrss_username = { };
    freshrss_password = { };
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
