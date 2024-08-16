{ config, lib, ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      ":5050".extraConfig = ''
        reverse_proxy :8083
      '';

      "sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8003
      '';

      "git.hypervirtual.world".extraConfig = ''
        reverse_proxy :3333
      '';

      "photos.hypervirtual.world".extraConfig = ''
        reverse_proxy :2342
      '';

      "books.hypervirtual.world".extraConfig = ''
        reverse_proxy :8083
      '';

      "fish.hypervirtual.world".extraConfig = ''
        reverse_proxy :3030
      '';

      ":2344".extraConfig = ''
        reverse_proxy :2342
      '';

      "jellyfin.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8096
      '';

      "slskd.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :5030
      '';

      "radarr.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :7878
      '';

      "sonarr.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8989
      '';

      "sonarr-anime.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8999
      '';

      "prowlarr.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :9696
      '';

      "grafana.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :3000
      '';

      "status.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :4000
      '';
    };
  };

}
