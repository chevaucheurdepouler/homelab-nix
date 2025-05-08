{ ... }:
{
  #TODO: implement uptime-kama
  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "4000";
    };
  };

  services.caddy.virtualHosts."http://status.rougebordeaux.xyz".extraConfig = ''
    reverse_proxy :4000
  '';

  services.caddy.virtualHosts."http://uptime.sisyphe.normandy.rougebordeaux.xyz.extraConfig = ''
    reverse_proxy :4000
  '';

}
