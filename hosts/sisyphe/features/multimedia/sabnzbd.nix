{config, pkgs, ...}:
{
  services.sabnzbd = {
    enable = true;

  };

  services.caddy.virtualHosts."http://sabnzbd.normandy.sisyphe.hypervirtual.world".extraConfig = ''
  reverse_proxy 8080
  ''; 
/*
  services.prometheus.exporters.sabnzbd = {
    enable = true;
    servers = [
      localhost
    ]
  };*/
}