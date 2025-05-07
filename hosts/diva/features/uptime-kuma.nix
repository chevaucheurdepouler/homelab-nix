{ ... }:
{
  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "4000";
    };
  };

  services.caddy.virtualHosts."http://status.hypervirtual.world".extraConfig = ''
    reverse_proxy :4000
  '';

  services.caddy.virtualHosts."http://uptime.diva.global.hypervirtual.world".extraConfig = ''
    reverse_proxy :4000
  '';
}
