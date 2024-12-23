{ config, lib, ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "http://fish.hypervirtual.world".extraConfig = ''
        reverse_proxy :3030
      '';

      "http://mc.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8443
      '';
    };
  };

}
