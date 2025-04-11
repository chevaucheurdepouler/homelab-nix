{ config, pkgs, ... }:
{
  services.sabnzbd = {
    enable = true;
    openFirewall = true;
  };

  services.caddy.virtualHosts."http://nzb.normandy.sisyphe.hypervirtual.world".extraConfig = ''
    reverse_proxy 8080
  '';

  /*
    services.prometheus.exporters.sabnzbd = {
      enable = true;
      servers = [
        {
          sisyphe = {

          };
        }
      ];
    };
  */
}
