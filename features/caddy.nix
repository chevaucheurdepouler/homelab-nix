{ config, lib, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = ''
      reverse_proxy :8082
    '';

    virtualHosts.":5050".extraConfig = ''
      reverse_proxy :8083
    '';
  };

}
