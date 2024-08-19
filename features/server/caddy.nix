{ config, lib, ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "http://sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8003
      '';

      "http://git.hypervirtual.world".extraConfig = ''
        reverse_proxy :3333
      '';

      "http://books.hypervirtual.world".extraConfig = ''
        reverse_proxy :8083
      '';

      "http://fish.hypervirtual.world".extraConfig = ''
        reverse_proxy :3030
      '';

      "http://jellyfin.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8096
      '';

      "http://slskd.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :5030
      '';

      "http://radarr.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :7878
      '';

      "http://sonarr.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8989
      '';

      "http://sonarr-anime.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8999
      '';

      "http://prowlarr.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :9696
      '';

      "http://grafana.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :3000
      '';

      "http://status.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :4000
      '';

      "http://transmission.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :9091
      '';
    };
  };

}
