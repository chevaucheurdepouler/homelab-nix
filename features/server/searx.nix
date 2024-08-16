{ config, ... }:
{
  sops.secrets."searx" = {
    sopsFile = ../secrets/searx.env;
    format = "dotenv";
  };

  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server.port = 8080;
      server.secret_key = builtins.toJSON config.sops.secrets."searx";

      server.bind_address = "0.0.0.0";
    };
  };
}
