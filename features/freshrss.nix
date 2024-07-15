{ config, lib, ... }:
{
  sops.defaultSopsFile = ../secrets/freshrss.json;
  sops.defaultSopsFormat = "json";
  sops.secrets = {
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
