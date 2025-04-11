{ ... }:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_port = 3000;
      };
    };
  };

  services.caddy.virtualHosts."http://grafana.sisyphe.normandy.hypervirtual.world".extraConfig = ''
    reverse_proxy :3000
  '';
}
