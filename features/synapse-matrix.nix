{ config, lib, ... }:
#TODO: implement 
{
  services.matrix-synapse = {
    enable = true;
    settings = {
      serverName = "talk.hypervirtual.world";
    };

    redis = {
      enabled = true;
    };
  };
}
