{ config, lib, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = ''
      reverse_proxy :8082
    '';

    virtualHosts.":3001".extraConfig = ''
      reverse_proxy :3000
    '';

    virtualHosts.":4001".extraConfig = ''
      reverse_proxy :4000
    '';

    virtualHosts.":5050".extraConfig = ''
      reverse_proxy :8083
    '';
  };

}
