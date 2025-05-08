{ config, lib, ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "http://fish.rougebordeaux.xyz".extraConfig = ''
        reverse_proxy :3030
      '';

      "http://mc.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
        reverse_proxy :8443
      '';
    };
  };

}
