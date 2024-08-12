{ config, lib, ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts.":5050".extraConfig = ''
      reverse_proxy :8083
    '';
    /*
        virtualHosts."sisyphe.normandy.hypervirtual.world".extraConfig = ''
          reverse_proxy :8003
        '';
    */

    virtualHosts."git.hypervirtual.world".extraConfig = ''
      reverse_proxy :3333
    '';

    virtualHosts."photos.hypervirtual.world".extraConfig = ''
      reverse_proxy :2342
    '';

    virtualHosts."books.hypervirtual.world".extraConfig = ''
      reverse_proxy :8083
    '';

    virtualHosts."fish.hypervirtual.world".extraConfig = ''
      reverse_proxy :3030
    '';

    virtualHosts.":2342".extraConfig = ''

      reverse_proxy :2344
    '';
    /*
        virtualHosts."jellyfin.normandy.hypervirtual.world".extraConfig = ''
          reverse_proxy :8096
        '';
    */
  };

}
