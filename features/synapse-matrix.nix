{
  pkgs,
  config,
  lib,
  ...
}:
#TODO: implement 
let
  baseUrl = "talk.hypervirtual.world";
in
{

  sops.secrets.matrix-shared-secret = {
    sopsFile = ../secrets/matrix.yaml;
    format = "yaml";
  };

  services.matrix-synapse = {
    enable = true;

    settings = {
      serverName = baseUrl;
      public_baseurl = baseUrl;
      enable_registration = false;
    };

    configureRedisLocally = true;

    extras = [
      "systemd"
      "postgres"
      "url-preview"
      "user-search"
    ];

    extraConfigFiles = [ "/run/secrets/matrix-shared-secret" ];

    listeners = [
      {
        port = 8008;
        bind_addresses = [ "::1" ];
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [
          {
            names = [
              "client"
              "federation"
            ];
            compress = true;
          }
        ];
      }
    ];
  };

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_15;
  };
}
