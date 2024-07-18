{ config, lib, ... }:
#TODO: implement 
{
  services.matrix-synapse = {
    enable = true;
    enable_registration = false;

    settings = {
      serverName = "talk.hypervirtual.world";
    };

    redis = {
      enabled = true;
    };
    extras = [
      "systemd"
      "postgres"
      "url-preview"
      "user-search"
    ];
  };
}
