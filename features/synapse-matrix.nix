{
  pkgs,
  config,
  lib,
  ...
}:
#TODO: implement 
let
  baseUrl = "https://talk.hypervirtual.world";
in
{
  networking.domain = "hypervirtual.world";
  sops.secrets.data = {
    sopsFile = ../secrets/matrix.yaml;
    format = "yaml";
    owner = "matrix-synapse";
  };

  services.matrix-synapse = {
    enable = true;

    settings = {
      server_name = "hypervirtual.world";
      public_baseurl = baseUrl;
      enable_registration = false;
      listeners = [
        {
          port = 8008;
          bind_addresses = [
            "::1"
            "0.0.0.0"
          ];
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

    extras = [
      "systemd"
      "postgres"
      "url-preview"
      "user-search"
    ];

    extraConfigFiles = [ "/run/secrets/data" ];

  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
  };
}
