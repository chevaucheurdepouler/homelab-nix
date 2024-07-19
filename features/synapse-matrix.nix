{ config, lib, ... }:
#TODO: implement 
{
  services.matrix-synapse = {
    enable = true;
    enable_registration = false;

    settings = {
      serverName = "talk.hypervirtual.world";
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
