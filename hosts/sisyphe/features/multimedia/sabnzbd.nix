{ ... }:
{
  services.sabnzbd = {
    enable = false;
    openFirewall = false;
  };

  services.caddy.virtualHosts."http://nzb.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
    reverse_proxy 8080
  '';
}
