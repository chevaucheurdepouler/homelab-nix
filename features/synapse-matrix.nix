{ config, lib, ... }:
#TODO: implement 
{
  services.matrix-synapse = {
    enable = true;

    settings = {
      serverName = "talk.hypervirtual.world";
      enable_registration = false;
    };

    configureRedisLocally = true;

    extras = [
      "systemd"
      "postgres"
      "url-preview"
      "user-search"
    ];
  };
}
