{ config, lib, ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      ":5050".extraConfig = ''
        reverse_proxy :8083
      '';

      "http://sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8003
      '';

      "http://git.hypervirtual.world".extraConfig = ''
        reverse_proxy :3333
      '';

      "http://photos.hypervirtual.world".extraConfig = ''
        reverse_proxy :2342
      '';

      "http://books.hypervirtual.world".extraConfig = ''
        reverse_proxy :8083
      '';

      "http://fish.hypervirtual.world".extraConfig = ''
        reverse_proxy :3030
      '';

      ":2344".extraConfig = ''
        reverse_proxy :2342
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
    };
  };

}
