{
  pkgs,
  config,
  lib,
  ...
}:
let
  baseUrl = "https://talk.rougebordeaux.xyz";
in
{
  networking.domain = "rougebordeaux.xyz";
  sops.secrets.matrix_data = {
    format = "yaml";
    owner = "matrix-synapse";
  };

  services.matrix-synapse = {
    enable = true;

    settings = {
      server_name = "rougebordeaux.xyz";
      public_baseurl = baseUrl;
      enable_registration = false;
      enable_metrics = true;
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
        {
          port = 9000;
          type = "metrics";
          tls = false;
          bind_addresses = [
            "::1"
            "127.0.0.1"
          ];
          resources = [ ];
        }
      ];
    };

    extras = [
      "systemd"
      "postgres"
      "url-preview"
      "user-search"
    ];

    extraConfigFiles = [ "/run/secrets/matrix_data" ];
  };

  /*
    services.mautrix-discord = {
      enable = true;
      environmentFile = "";

      settings = {
        homeserver = {
          address = "http://localhost:8008";
          domain = "rougebordeaux.xyz";
        };
        appservice = {
          provisioning.enabled = false;
          id = "discord";
          public = {

          };

          database = "";
        };

      };
    };
  */

}
