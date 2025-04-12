{ ... }:
{
  services.sabnzbd = {
    enable = true;
    openFirewall = true;
  };

  services.caddy.virtualHosts."http://nzb.sisyphe.normandy.hypervirtual.world".extraConfig = ''
    reverse_proxy 8080
  '';
}
